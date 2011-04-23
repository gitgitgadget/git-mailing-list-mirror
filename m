From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: add option to preserve user names
Date: Sat, 23 Apr 2011 07:54:19 -0400
Message-ID: <20110423115419.GA6925@arf.padd.com>
References: <1303415423-12445-1-git-send-email-luke@diamand.org>
 <1303415423-12445-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 13:54:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDbQ8-00076F-Hy
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 13:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab1DWLyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 07:54:24 -0400
Received: from honk.padd.com ([74.3.171.149]:52057 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab1DWLyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 07:54:23 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 9CB7C20CA;
	Sat, 23 Apr 2011 04:54:21 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 98F6C319E7; Sat, 23 Apr 2011 07:54:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1303415423-12445-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171982>

luke@diamand.org wrote on Thu, 21 Apr 2011 20:50 +0100:
> Patches from git passed into p4 end up with the committer
> being identified as the person who ran git-p4.
> 
> With "submit --preserve-user", git-p4 modifies the p4
> changelist (after it has been submitted), setting the
> p4 author field.
> 
> The submitter is required to have sufficient p4 permissions
> or git-p4 refuses to proceed. If the git author is not
> known to p4, the submit will be abandoned unless
> git-p4.allowMissingP4Users is true.
> 
> Signed-off-by: Luke Diamand <luke@diamand.org>

I like this patch.  Quite impressed with the care you put into
refactoring, handling all the error cases, and documentation too.

Acked-by: Pete Wyckoff <pw@padd.com>

Maybe wait for some more comments, then send it to Junio in a week.

		-- Pete


> ---
>  contrib/fast-import/git-p4     |  179 +++++++++++++++++++++++++++++++---------
>  contrib/fast-import/git-p4.txt |   29 +++++++
>  t/t9800-git-p4.sh              |   84 +++++++++++++++++++
>  3 files changed, 254 insertions(+), 38 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 78e5b3a..36e3d87 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -474,6 +474,47 @@ class Command:
>          self.usage = "usage: %prog [options]"
>          self.needsGit = True
>  
> +class P4UserMap:
> +    def __init__(self):
> +        self.userMapFromPerforceServer = False
> +
> +    def getUserCacheFilename(self):
> +        home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
> +        return home + "/.gitp4-usercache.txt"
> +
> +    def getUserMapFromPerforceServer(self):
> +        if self.userMapFromPerforceServer:
> +            return
> +        self.users = {}
> +        self.emails = {}
> +
> +        for output in p4CmdList("users"):
> +            if not output.has_key("User"):
> +                continue
> +            self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
> +            self.emails[output["Email"]] = output["User"]
> +
> +
> +        s = ''
> +        for (key, val) in self.users.items():
> +            s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
> +
> +        open(self.getUserCacheFilename(), "wb").write(s)
> +        self.userMapFromPerforceServer = True
> +
> +    def loadUserMapFromCache(self):
> +        self.users = {}
> +        self.userMapFromPerforceServer = False
> +        try:
> +            cache = open(self.getUserCacheFilename(), "rb")
> +            lines = cache.readlines()
> +            cache.close()
> +            for line in lines:
> +                entry = line.strip().split("\t")
> +                self.users[entry[0]] = entry[1]
> +        except IOError:
> +            self.getUserMapFromPerforceServer()
> +
>  class P4Debug(Command):
>      def __init__(self):
>          Command.__init__(self)
> @@ -554,13 +595,16 @@ class P4RollBack(Command):
>  
>          return True
>  
> -class P4Submit(Command):
> +class P4Submit(Command, P4UserMap):
>      def __init__(self):
>          Command.__init__(self)
> +        P4UserMap.__init__(self)
>          self.options = [
>                  optparse.make_option("--verbose", dest="verbose", action="store_true"),
>                  optparse.make_option("--origin", dest="origin"),
>                  optparse.make_option("-M", dest="detectRenames", action="store_true"),
> +                # preserve the user, requires relevant p4 permissions
> +                optparse.make_option("--preserve-user", dest="preserveUser", action="store_true"),
>          ]
>          self.description = "Submit changes from git to the perforce depot."
>          self.usage += " [name of git branch to submit into perforce depot]"
> @@ -568,6 +612,7 @@ class P4Submit(Command):
>          self.origin = ""
>          self.detectRenames = False
>          self.verbose = False
> +        self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
>          self.isWindows = (platform.system() == "Windows")
>  
>      def check(self):
> @@ -602,6 +647,75 @@ class P4Submit(Command):
>  
>          return result
>  
> +    def p4UserForCommit(self,id):
> +        # Return the tuple (perforce user,git email) for a given git commit id
> +        self.getUserMapFromPerforceServer()
> +        gitEmail = read_pipe("git log --max-count=1 --format='%%ae' %s" % id)
> +        gitEmail = gitEmail.strip()
> +        if not self.emails.has_key(gitEmail):
> +            return (None,gitEmail)
> +        else:
> +            return (self.emails[gitEmail],gitEmail)
> +
> +    def checkValidP4Users(self,commits):
> +        # check if any git authors cannot be mapped to p4 users
> +        for id in commits:
> +            (user,email) = self.p4UserForCommit(id)
> +            if not user:
> +                msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
> +                if gitConfig('git-p4.allowMissingP4Users').lower() == "true":
> +                    print "%s" % msg
> +                else:
> +                    die("Error: %s\nSet git-p4.allowMissingP4Users to true to allow this." % msg)
> +
> +    def lastP4Changelist(self):
> +        # Get back the last changelist number submitted in this client spec. This
> +        # then gets used to patch up the username in the change. If the same
> +        # client spec is being used by multiple processes then this might go
> +        # wrong.
> +        results = p4CmdList("client -o")        # find the current client
> +        client = None
> +        for r in results:
> +            if r.has_key('Client'):
> +                client = r['Client']
> +                break
> +        if not client:
> +            die("could not get client spec")
> +        results = p4CmdList("changes -c %s -m 1" % client)
> +        for r in results:
> +            if r.has_key('change'):
> +                return r['change']
> +        die("Could not get changelist number for last submit - cannot patch up user details")
> +
> +    def modifyChangelistUser(self, changelist, newUser):
> +        # fixup the user field of a changelist after it has been submitted.
> +        changes = p4CmdList("change -o %s" % changelist)
> +        for c in changes:
> +            if c.has_key('User'):
> +                c['User'] = newUser
> +        input = marshal.dumps(changes[0])
> +        result = p4CmdList("change -f -i", stdin=input)
> +        for r in result:
> +            if r.has_key('code'):
> +                if r['code'] == 'error':
> +                    die("Could not modify user field of changelist %s to %s:%s" % (changelist, newUser, r['data']))
> +            if r.has_key('data'):
> +                print("Updated user field for changelist %s to %s" % (changelist, newUser))
> +                return
> +        die("Could not modify user field of changelist %s to %s" % (changelist, newUser))
> +
> +    def canChangeChangelists(self):
> +        # check to see if we have p4 admin or super-user permissions, either of
> +        # which are required to modify changelists.
> +        results = p4CmdList("-G protects %s" % self.depotPath)
> +        for r in results:
> +            if r.has_key('perm'):
> +                if r['perm'] == 'admin':
> +                    return 1
> +                if r['perm'] == 'super':
> +                    return 1
> +        return 0
> +
>      def prepareSubmitTemplate(self):
>          # remove lines in the Files section that show changes to files outside the depot path we're committing into
>          template = ""
> @@ -631,6 +745,9 @@ class P4Submit(Command):
>      def applyCommit(self, id):
>          print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
>  
> +        if self.preserveUser:
> +            (p4User, gitEmail) = self.p4UserForCommit(id)
> +
>          if not self.detectRenames:
>              # If not explicitly set check the config variable
>              self.detectRenames = gitConfig("git-p4.detectRenames").lower() == "true"
> @@ -781,8 +898,13 @@ class P4Submit(Command):
>                  editor = read_pipe("git var GIT_EDITOR").strip()
>              system(editor + " " + fileName)
>  
> +            if gitConfig("git-p4.skipSubmitEditCheck") == "true":
> +                checkModTime = False
> +            else:
> +                checkModTime = True
> +
>              response = "y"
> -            if os.stat(fileName).st_mtime <= mtime:
> +            if checkModTime and (os.stat(fileName).st_mtime <= mtime):
>                  response = "x"
>                  while response != "y" and response != "n":
>                      response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
> @@ -795,6 +917,14 @@ class P4Submit(Command):
>                  if self.isWindows:
>                      submitTemplate = submitTemplate.replace("\r\n", "\n")
>                  p4_write_pipe("submit -i", submitTemplate)
> +
> +                if self.preserveUser:
> +                    if p4User:
> +                        # Get last changelist number. Cannot easily get it from
> +                        # the submit command output as the output is unmarshalled.
> +                        changelist = self.lastP4Changelist()
> +                        self.modifyChangelistUser(changelist, p4User)
> +
>              else:
>                  for f in editedFiles:
>                      p4_system("revert \"%s\"" % f);
> @@ -831,6 +961,10 @@ class P4Submit(Command):
>          if len(self.origin) == 0:
>              self.origin = upstream
>  
> +        if self.preserveUser:
> +            if not self.canChangeChangelists():
> +                die("Cannot preserve user names without p4 super-user or admin permissions")
> +
>          if self.verbose:
>              print "Origin branch is " + self.origin
>  
> @@ -858,6 +992,9 @@ class P4Submit(Command):
>              commits.append(line.strip())
>          commits.reverse()
>  
> +        if self.preserveUser:
> +            self.checkValidP4Users(commits)
> +
>          while len(commits) > 0:
>              commit = commits[0]
>              commits = commits[1:]
> @@ -877,11 +1014,12 @@ class P4Submit(Command):
>  
>          return True
>  
> -class P4Sync(Command):
> +class P4Sync(Command, P4UserMap):
>      delete_actions = ( "delete", "move/delete", "purge" )
>  
>      def __init__(self):
>          Command.__init__(self)
> +        P4UserMap.__init__(self)
>          self.options = [
>                  optparse.make_option("--branch", dest="branch"),
>                  optparse.make_option("--detect-branches", dest="detectBranches", action="store_true"),
> @@ -1236,41 +1374,6 @@ class P4Sync(Command):
>                      print ("Tag %s does not match with change %s: file count is different."
>                             % (labelDetails["label"], change))
>  
> -    def getUserCacheFilename(self):
> -        home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
> -        return home + "/.gitp4-usercache.txt"
> -
> -    def getUserMapFromPerforceServer(self):
> -        if self.userMapFromPerforceServer:
> -            return
> -        self.users = {}
> -
> -        for output in p4CmdList("users"):
> -            if not output.has_key("User"):
> -                continue
> -            self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
> -
> -
> -        s = ''
> -        for (key, val) in self.users.items():
> -            s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
> -
> -        open(self.getUserCacheFilename(), "wb").write(s)
> -        self.userMapFromPerforceServer = True
> -
> -    def loadUserMapFromCache(self):
> -        self.users = {}
> -        self.userMapFromPerforceServer = False
> -        try:
> -            cache = open(self.getUserCacheFilename(), "rb")
> -            lines = cache.readlines()
> -            cache.close()
> -            for line in lines:
> -                entry = line.strip().split("\t")
> -                self.users[entry[0]] = entry[1]
> -        except IOError:
> -            self.getUserMapFromPerforceServer()
> -
>      def getLabels(self):
>          self.labels = {}
>  
> diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
> index e09da44..b6986f0 100644
> --- a/contrib/fast-import/git-p4.txt
> +++ b/contrib/fast-import/git-p4.txt
> @@ -110,6 +110,12 @@ is not your current git branch you can also pass that as an argument:
>  
>  You can override the reference branch with the --origin=mysourcebranch option.
>  
> +The Perforce changelists will be created with the user who ran git-p4. If you
> +use --preserve-user then git-p4 will attempt to create Perforce changelists
> +with the Perforce user corresponding to the git commit author. You need to
> +have sufficient permissions within Perforce, and the git users need to have
> +Perforce accounts. Permissions can be granted using 'p4 protect'.
> +
>  If a submit fails you may have to "p4 resolve" and submit manually. You can
>  continue importing the remaining changes with
>  
> @@ -196,6 +202,29 @@ able to find the relevant client.  This client spec will be used to
>  both filter the files cloned by git and set the directory layout as
>  specified in the client (this implies --keep-path style semantics).
>  
> +git-p4.skipSubmitModTimeCheck
> +
> +  git config [--global] git-p4.skipSubmitModTimeCheck false
> +
> +If true, submit will not check if the p4 change template has been modified.
> +
> +git-p4.preserveUser
> +
> +  git config [--global] git-p4.preserveUser false
> +
> +If true, attempt to preserve user names by modifying the p4 changelists. See
> +the "--preserve-user" submit option.
> +
> +git-p4.allowMissingPerforceUsers
> +
> +  git config [--global] git-p4.allowMissingP4Users false
> +
> +If git-p4 is setting the perforce user for a commit (--preserve-user) then
> +if there is no perforce user corresponding to the git author, git-p4 will
> +stop. With allowMissingPerforceUsers set to true, git-p4 will use the
> +current user (i.e. the behavior without --preserve-user) and carry on with
> +the perforce commit.
> +
>  Implementation Details...
>  =========================
>  
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index a523473..fd3204b 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -12,6 +12,8 @@ test_description='git-p4 tests'
>  GITP4=$GIT_BUILD_DIR/contrib/fast-import/git-p4
>  P4DPORT=10669
>  
> +export P4PORT=localhost:$P4DPORT
> +
>  db="$TRASH_DIRECTORY/db"
>  cli="$TRASH_DIRECTORY/cli"
>  git="$TRASH_DIRECTORY/git"
> @@ -129,6 +131,88 @@ test_expect_success 'clone bare' '
>  	rm -rf "$git" && mkdir "$git"
>  '
>  
> +p4_add_user() {
> +    name=$1
> +    fullname=$2
> +    p4 user -f -i <<EOF &&
> +User: $name
> +Email: $name@localhost
> +FullName: $fullname
> +EOF
> +    p4 passwd -P secret $name
> +}
> +
> +p4_grant_admin() {
> +    name=$1
> +    p4 protect -o |\
> +        awk "{print}END{print \"    admin user $name * //depot/...\"}" |\
> +        p4 protect -i
> +}
> +
> +p4_check_commit_author() {
> +    file=$1
> +    user=$2
> +    if p4 changes -m 1 //depot/$file | grep $user > /dev/null ; then
> +        return 0
> +    else
> +        echo "file $file not modified by user $user" 1>&2
> +        return 1
> +    fi
> +}
> +
> +# Test username support, submitting as user 'alice'
> +test_expect_success 'preserve users' '
> +	p4_add_user alice Alice &&
> +	p4_add_user bob Bob &&
> +	p4_grant_admin alice &&
> +	"$GITP4" clone --dest="$git" //depot &&
> +	cd "$git" &&
> +	echo "username: a change by alice" >> file1 &&
> +	echo "username: a change by bob" >> file2 &&
> +	git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
> +	git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
> +	git config git-p4.skipSubmitEditCheck true &&
> +	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
> +	p4_check_commit_author file1 alice &&
> +	p4_check_commit_author file2 bob &&
> +	cd "$TRASH_DIRECTORY" &&
> +	rm -rf "$git" && mkdir "$git"
> +'
> +
> +# Test username support, submitting as bob, who lacks admin rights. Should
> +# not submit change to p4 (git diff should show deltas).
> +test_expect_success 'refuse to preserve users without perms' '
> +	"$GITP4" clone --dest="$git" //depot &&
> +	cd "$git" &&
> +	echo "username-noperms: a change by alice" >> file1 &&
> +	git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
> +	! P4EDITOR=touch P4USER=bob P4PASSWD=secret "$GITP4" commit --preserve-user &&
> +	! git diff --exit-code HEAD..p4/master > /dev/null &&
> +	cd "$TRASH_DIRECTORY" &&
> +	rm -rf "$git" && mkdir "$git"
> +'
> +
> +# What happens with unknown author? Without allowMissingP4Users it should fail.
> +test_expect_success 'preserve user where author is unknown to p4' '
> +	"$GITP4" clone --dest="$git" //depot &&
> +	cd "$git" &&
> +	git config git-p4.skipSubmitEditCheck true
> +	echo "username-bob: a change by bob" >> file1 &&
> +	git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
> +	echo "username-unknown: a change by charlie" >> file1 &&
> +	git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
> +	! P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
> +	! git diff --exit-code HEAD..p4/master > /dev/null &&
> +	echo "$0: repeat with allowMissingP4Users enabled" &&
> +	git config git-p4.allowMissingP4Users true &&
> +	git config git-p4.preserveUser true &&
> +	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit &&
> +	git diff --exit-code HEAD..p4/master > /dev/null &&
> +	p4_check_commit_author file1 alice &&
> +	cd "$TRASH_DIRECTORY" &&
> +	rm -rf "$git" && mkdir "$git"
> +'
> +
>  test_expect_success 'shutdown' '
>  	pid=`pgrep -f p4d` &&
>  	test -n "$pid" &&
> -- 
> 1.7.1
> 
