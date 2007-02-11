From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: darcs2git.py - convert darcs repository using gfi
Date: Mon, 12 Feb 2007 00:56:34 +0100
Message-ID: <eqoaf7$loq$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010302080102020309040808"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 00:56:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOYr-0004lx-Tg
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbXBKX4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbXBKX4m
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:56:42 -0500
Received: from main.gmane.org ([80.91.229.2]:42623 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932935AbXBKX4k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:56:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HGOYa-00048F-BD
	for git@vger.kernel.org; Mon, 12 Feb 2007 00:56:32 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 00:56:32 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 00:56:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39339>

This is a multi-part message in MIME format.
--------------010302080102020309040808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The python script attached is a try at providing a sane
conversion from Darcs to GIT.  It tries to map darcs conflict
resolutions onto git branch merges.

Regarding GFI, it's a breeze to work with; my compliments to its
author. My only gripe is the need to specify a branch for each commit.
Darcs uses changeset based storage. It doesn't really have branches,
but it does record divergent changes and merges of resulting
conflicts.  Hence, it's not clear which refs/head/BRANCH should be
used when creating a commit object.

I found it easiest to write each commit to a

  refs/head/darcs-tmp-COUNT

branch, use the reset command to specify at the end which commits are
tops of branches, and delete the temporary branches.

So, my feature request: please make the "commit" command always accept
a "from" command, and make the "refs" argument optional.  This will
cleanup my converter, and separate out two logical functions of the
gfi "commit" command: creating a commit object, and advancing the head
ref.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

--------------010302080102020309040808
Content-Type: text/x-python;
 name="darcs2git.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="darcs2git.py"

import os  
import sys
import time
import xml.dom.minidom
import re
import gdbm as dbmodule
import gzip
import optparse

################################################################
# globals

silent=False
mail_to_name_dict = {}
pending_patches = {}
used_tags = {}

################################################################
# utils

class PullConflict (Exception):
    pass
class CommandFailed (Exception):
    pass

def progress (s):
    sys.stderr.write (s + '\n')
    
def get_cli_options ():
    p = optparse.OptionParser ()

    p.usage='''darcs2git [OPTIONS] DARCS-REPO'''
    p.description='''Convert darcs repo to git.

This tool is a one shot conversion utility for Darcs repositories.  It
requires Git version that has git-fast-import.  It does not support
incremental updating.

This tool will import the patches in chronological order, and only creates
merges when a resolved conflict is detected.

TODO:

- correct time zone handling
- 

'''

    def update_map (option, opt, value, parser):
        for l in open (value).readlines ():
            (mail, name) = tuple (l.strip ().split ('='))
            mail_to_name_dict[mail] = name

    p.add_option ('-a', '--authors', action='callback',
                  callback=update_map,
                  type='string',
                  nargs=1,
                  help='read a text file, containing EMAIL=NAME lines')

    p.add_option ('-d', '--destination', action='store',
                  type='string',
                  default='',
                  dest='target_git_repo',
                  help='where to put the resulting Git repo.')

    p.add_option ('--verbose', action='store_true',
                  dest='verbose',
                  default=False, 
                  help='show commands as they are invoked')
    
    options, args = p.parse_args ()
    if not args:
        p.print_help ()
        sys.exit (2)
        
    global silent
    silent = not options.verbose

    if not options.target_git_repo:
        p = args[0]
        p = os.path.abspath (p)
        options.target_git_repo = os.path.basename (p).replace ('.darcs', '')
        options.target_git_repo += '.git' 
       
        
    return (options, args)

def read_pipe (cmd, ignore_errors=False):
    if not silent:
        progress ('pipe %s' % cmd)
    pipe = os.popen (cmd)

    val = pipe.read ()
    if pipe.close () and not ignore_errors:
        raise CommandFailed ("Pipe failed: %s" % cmd)
    
    return val

def system (c, ignore_error=0):
    if not silent:
        progress ( c)
    if os.system (c) and not ignore_error:
        raise CommandFailed ("Command failed: %s" % c)

def darcs_date_to_git (x):
    t = time.strptime (x, '%Y%m%d%H%M%S')
    return '%d' % int (time.mktime (t))

def darcs_timezone (x) :
    time.strptime (x, '%a %b %d %H:%M:%S %Z %Y')

    # todo
    return "+0100"

################################################################
# darcs

class DarcsConversionRepo:
    def __init__ (self, dir, patches):
        self.dir = dir
        self.patches = patches
        
    def clean (self):
        system ('rm -rf %s' % self.dir)
        
    def pull (self, patch):
        id = patch.attributes['hash']
        source_repo = patch.dir
        dir = self.dir
        system ('cd %(dir)s && darcs pull --quiet --all --match "hash %(id)s" %(source_repo)s ' % locals ())

    def go_from_to (self, from_patch, to_patch):

        """Move the repo to FROM_PATCH, then go to TO_PATCH. Raise
        PullConflict if conflict is detected

        This uses the fishy technique of writing the inventory and
        constructing the pristine tree with 'darcs repair'

        It might be quicker and/or more correct to wind/rewind the
        repo with pull and unpull.  """

        
        dir = os.path.abspath (self.dir)
        system ('rm -rf %(dir)s && mkdir %(dir)s && darcs init --repo  %(dir)s'
                % locals ())
    
        source = to_patch.dir
        if from_patch:
            iv = open (dir + '/_darcs/inventory', 'w')
            for p in self.patches[:from_patch.number+1]:
                os.link (p.filename (), dir + '/_darcs/patches/' + os.path.basename (p.filename ()))
                iv.write (p.header ())
                
            iv.close ()

            progress ('Go to patch %d' % from_patch.number)
            system ('cd %(dir)s && darcs repair --quiet' % locals ())
            system ('rsync -a  %(dir)s/_darcs/pristine/ %(dir)s/' % locals ())
        try:
            self.pull (to_patch)
            success = 'No conflicts to resolve' in read_pipe ('cd %(dir)s && echo y|darcs resolve' % locals  ())
        except CommandFailed:
            raise PullConflict ()
    

        if not success:
            raise PullConflict ()

    def has_patch (self, p):
        id = p.attributes['hash']
        f = self.dir + '/_darcs/patches/' + id
        return os.path.exists (f)

    def pristine_tree (self):
        return self.dir + '/_darcs/pristine'
    
class DarcsPatch:
    def __init__ (self, xml, dir):
        self.xml = xml
        self.dir = dir
        self.number = -1
        self.attributes = {}
        for (nm, value) in xml.attributes.items():
            self.attributes[nm] = value

        # fixme: ugh attributes vs. methods.
        self.extract_author ()
        self.extract_message ()
        self.extract_time ()

    def filename (self):
        return self.dir + '/_darcs/patches/' + self.attributes['hash']

    def contents (self):
        f = gzip.open (self.filename ())
        return f.read ()

    def header (self):
        lines = self.contents ().split ('\n')

        name = lines[0]
        committer = lines[1] + '\n'
        committer = re.sub ('] {\n$', ']\n', committer)
        committer = re.sub ('] *\n$', ']\n', committer)
        comment = ''
        if not committer.endswith (']\n'):
            for l in lines[2:]:
                if l[0] == ']':
                    comment += ']\n'
                    break
                comment += l + '\n'

        header = name  + '\n' + committer 
        if comment:
            header += comment
   
        return header

    def extract_author (self):
        mail = self.attributes['author']
        name = ''
        m = re.search ("^(.*) <(.*)>$", mail)

        if m:
            name = m.group (1)
            mail = m.group (2)
        else:
            try:
                name = mail_to_name_dict[mail]
            except KeyError:
                name = mail.split ('@')[0]

        self.author_name = name
        self.author_mail = mail

    def extract_time (self):
        self.date = darcs_date_to_git (self.attributes['date']) + ' ' + darcs_timezone (self.attributes['local_date'])

    def name (self):
        patch_name = '(no comment)'
        try:
            name_elt = self.xml.getElementsByTagName ('name')[0]
            patch_name = name_elt.childNodes[0].data
        except IndexError:
            pass
        return patch_name
    
    def extract_message (self):
        patch_name = self.name ()
        comment_elts = self.xml.getElementsByTagName ('comment')
        comment = ''
        if comment_elts:
            comment = comment_elts[0].childNodes[0].data

        if self.attributes['inverted'] == 'True':
            patch_name = 'UNDO: ' + patch_name

        self.message = '%s\n\n%s' % (patch_name, comment)

    def tag_name (self):
        patch_name = self.name ()
        if patch_name.startswith ("TAG "):
           tag = patch_name[4:]
           tag = re.sub (r'\s', '_', tag).strip ()
           tag = re.sub (r':', '_', tag).strip ()
           return tag
        return ''

def get_darcs_patches (darcs_repo):
    progress ('reading patches.')
    
    xml_string = read_pipe ('darcs changes --xml --reverse --repo ' + darcs_repo)

    dom = xml.dom.minidom.parseString(xml_string)
    xmls = dom.documentElement.getElementsByTagName('patch')

    patches = [DarcsPatch (x, darcs_repo) for x in xmls]

    n = 0
    for p in patches:
        p.number = n
        n += 1

    return patches

################################################################
# GIT export

def export_tree (tree, gfi):
    tree = os.path.normpath (tree)
    gfi.write ('deleteall\n')
    for (root, dirs, files) in os.walk (tree):
        for f in files:
            rf = os.path.normpath (os.path.join (root, f))
            s = open (rf).read ()
            rf = rf.replace (tree + '/', '')
            
            gfi.write ('M 644 inline %s\n' % rf)
            gfi.write ('data %d\n%s\n' % (len (s), s))
    gfi.write ('\n')

    
def export_commit (repo, patch, last_patch, gfi):
    gfi.write ('commit refs/heads/darcstmp%d\n' % patch.number)
    gfi.write ('mark :%d\n' % (patch.number + 1))
    gfi.write ('committer %s <%s> %s\n' % (patch.author_name,
                                           patch.author_mail,
                                           patch.date))
    gfi.write ('data %d\n%s\n' % (len (patch.message), patch.message))
    if last_patch:
        gfi.write ('from :%d\n' % (last_patch.number + 1))
        if pending_patches.has_key (last_patch.number):
            del pending_patches[last_patch.number]
        
    for (n, p) in pending_patches.items ():
        if repo.has_patch (p):
            gfi.write ('merge :%d\n' % (n + 1))
            del pending_patches[n]
        
    pending_patches[patch.number] = patch
    export_tree (repo.pristine_tree (), gfi)

def export_pending (gfi):
    if len (pending_patches.items ()) == 1:
        gfi.write ('reset refs/heads/master\n')
        gfi.write ('from :%d\n\n' % (pending_patches.values()[0].number+1))
        return
    
    
    for (n, p) in pending_patches.items ():
        gfi.write ('reset refs/heads/master%d\n' % n)
        gfi.write ('from :%d\n\n' % (n+1))

    patches = pending_patches.values()
    patch = patches[0]
    gfi.write ('commit refs/heads/master\n')
    gfi.write ('committer %s <%s> %s\n' % (patch.author_name,
                                           patch.author_mail,
                                           patch.date))
    msg = 'tie together'
    gfi.write ('data %d\n%s\n' % (len(msg), msg))
    gfi.write ('from :%d\n' % (patch.number + 1))
    for p in patches[1:]:
        gfi.write ('merge :%d\n' % (p.number + 1))
    gfi.write ('\n')
        
    
def export_tag (patch, gfi):
    gfi.write ('tag %s\n' % patch.tag_name ())
    gfi.write ('from :%d\n' % (patch.number + 1))
    gfi.write ('tagger %s <%s> %s\n' % (patch.author_name,
                                    patch.author_mail,
                                    patch.date))
    gfi.write ('data %d\n%s\n' % (len (patch.message),
                                  patch.message))
    
################################################################
# main.
def main ():

    (options, args) = get_cli_options ()
    
    darcs_repo = os.path.abspath (args[0])
    git_repo = os.path.abspath (options.target_git_repo)
    
    system ('mkdir %(git_repo)s && cd %(git_repo)s && git --bare init' % locals ())
    os.environ['GIT_DIR'] = git_repo

    gfi = os.popen ('git-fast-import', 'w')    #
    
    patches = get_darcs_patches (darcs_repo)

    conv_repo = DarcsConversionRepo ("darcs2git.tmpdarcs", patches)
    for p in patches:
        parent = p.number - 1

        last = None
        while 1:
            if parent >= 0:
                last = patches[parent]

            try:
                conv_repo.go_from_to (last, p)
                break
            except PullConflict:
                ## simplistic, may not be enough.
                progress ('conflict, going one back')
                parent -= 1

                if parent < 0:
                    raise Exception('urg')

        progress ('Export %d -> %d (total %d)' % (parent,
                                                 p.number, len (patches)))
        export_commit (conv_repo, p, last, gfi)
        if p.tag_name ():
            export_tag (p, gfi)
    export_pending (gfi)
    gfi.close ()

    system ('rm %(git_repo)s/refs/heads/darcstmp*' % locals ())
    conv_repo.clean ()
    
main ()

--------------010302080102020309040808--
