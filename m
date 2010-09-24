From: Artur Skawina <art.08.09@gmail.com>
Subject: git-show-merge-path v1.0
Date: Fri, 24 Sep 2010 21:03:54 +0200
Message-ID: <4C9CF61A.6060300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:04:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzDZ0-0007je-Ej
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab0IXTEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 15:04:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55416 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab0IXTD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 15:03:59 -0400
Received: by eyb6 with SMTP id 6so852609eyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:openpgp
         :content-type:content-transfer-encoding;
        bh=9PjLNwFlF0+Lp/JL0MGy7rJezAvrKFN6Zk3OGjoA3Ec=;
        b=Wqn6WD+b3It0pyVr7sskG53FECk9hcLFs45cHeibK1R5HYbFPcUdJwme66Gf32Q+21
         R125AaVewByD+tKo97ft8Mjs00sTxPE4DH5jEE4rCGPy02FnkZlRp1/DAeKvEaBC+Tjz
         b9MwuhHP3bzXKj5I55uCN2ASj+r2YB+pLPS9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=Lnmw7IOa5i1fbc/PN2U26tOKOhtBWDLRelbanVDe7xMr5XsxorcATp5lg/bY1KBDJM
         0/JrTFaxdXOji8Vv69rcZZqldHNvMtRzk7l3T/9lOyaW0acPnHfZ1dM/TPmr/bvyhbMS
         SIQsyF98amIKD8+FdwXQI/jtdEGRW+9SSgWmA=
Received: by 10.213.19.203 with SMTP id c11mr667066ebb.31.1285355038152;
        Fri, 24 Sep 2010 12:03:58 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-126-50.multimo.pl [89.174.126.50])
        by mx.google.com with ESMTPS id v59sm3572196eeh.10.2010.09.24.12.03.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 12:03:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157037>

This started as a quick graph walking hack, but evolved into something that
can actually be useful.

git-show-merge-path can tell /if/, /how/ and /when/ a change became visible
from a certain branch or tag. Or a few hundred thereof.

"git-show-merge-path <commit> <targets>".

$ git-show-merge-path <commit> heads    # checks all local branches
$ git-show-merge-path <commit> tags     # checks all tags
$ git-show-merge-path <commit> heads/as # checks all local branches named 'as/...'
$ git-show-merge-path <commit> remotes/name
                                        # checks all refs of the named remote
$ git-show-merge-path <commit> remotes  # checks all refs of all remotes
$ git-show-merge-path <commit> heads/master
                                        # checks the local 'master' branch
$ git-show-merge-path <commit> master   # checks all 'master' branches
                                        # (incl. remotes etc)
$ git-show-merge-path <commit> 'doh*'   # checks all branches named 'doh...'
$ git-show-merge-path <commit> 'tags/v2.*' # checks all tags beginning w/ "v2."
$ git-show-merge-path <commit> '*'      # checks every reference it finds
$ git-show-merge-path <commit> refs/heads/master # for nonhumans, or situations
                                        # where the DWIM approach fails.

Eg inside a git.git clone "git-show-merge-path 829ef38 next" will say
how 829ef38 merged into 'origin/next' and "git-show-merge-path 829ef38 origin"
will report the status vs all the branches in that repo;

$ git-show-merge-path 829ef38 origin
12f7559e0634 M: 'dm/mergetool-vimdiff' => next                        100922 16:36
          \_ Merged into next and pu [v1.7.3-60-g12f7559]
             Not reachable from HEAD, html, maint, man, master and todo

Checking which release included some change could look like this:

$ git-show-merge-path 657b6245b tags
44f9e6c6bc50 M: 'nouveau/for-airlied' => drm-linus                    091223 00:28
f42ecb2808db M: 'drm-linus'@$KO/airlied/drm-2.6                       091223 16:59
          \_ Merged into v2.6.33, v2.6.33-rc2, v2.6.33-rc3, v2.6.33-rc4, v2.6.33-rc5,
 v2.6.33-rc6, v2.6.33-rc7, v2.6.33-rc8, v2.6.33.1, v2.6.33.2, v2.6.34, v2.6.34-rc1,
 v2.6.34-rc2, v2.6.34-rc3, v2.6.34-rc4, v2.6.34-rc5, v2.6.34-rc6, v2.6.34-rc7, v2.6.34.1,
 v2.6.35, v2.6.35-rc1, v2.6.35-rc2, v2.6.35-rc3, v2.6.35-rc4, v2.6.35-rc5, v2.6.35-rc6,
 v2.6.35.1, v2.6.35.2, v2.6.35.3, v2.6.36-rc1 and v2.6.36-rc2 [v2.6.33-rc1-266-gf42ecb2]
[followed by some uninteresting merges, and a long list of tagged releases which
 do not contain this commit]

Note that the ref names it prints are simplified; if unsure, do not
rely on the DWIM target selection, just give it a full "refs/..." name.

artur

----------------------------------------------------------------------
#! /usr/bin/env pike
// git-show-merge-path <rev> [long-lived-branch(es)]
// v. 1.0
// Will show all external merge commits starting at <rev> until
// this commit appears on the specified branches. When that happens
// "Merged into <branchlist>" is printed. If <rev> is still
// unreachable from some of the branches then the search continues.
// If at least one of the branches does not contain <rev> then $0
// can and will print *all* merges (ie it won't stop at the last
// of the given branches containing this commit), followed by 
// "Not reachable from <branchlist>". This is a feature (can be
// used to find leaks outside of the given branches).
//
#define die(a...) exit(1, "Aborting; %s"+a)

static mapping commits = ([]);

array parsecommits(string ... delim) {
   array res = ({});
   string id;
   array lines = run("git", "rev-list", "--format=raw", "--ancestry-path",
                                        "--date-order", @delim)/"\n";
   foreach (lines, string line) {
      array words = line/" ";
      string h = words[0];
      if (h=="commit") {
         id = words[1];
         if (!commits[id])
            commits[id] = ([]);
         res += ({id});
         if (mapping bs = livebranches[id])
            commits[id]["Branch"] += bs;
      } else if (h=="") {
         if (commits[id])
            commits[id][""] += ({line});
      }
      else {
         if (h=="parent" && !commits[id]["parent"] && commits[id]["Branch"]) {
            string firstparent = words[1];
            if (!commits[firstparent])
               commits[firstparent] = ([ "Branch" : commits[id]["Branch"] ]);
            else
               commits[firstparent]["Branch"] += commits[id]["Branch"];
         }
         commits[id][h] += words[1..];
      }
   }
   return res;
}

static mapping desc = ([]);

static mapping livebranches = ([]); // id : mapping(name:id)
static mapping branchnames = ([]);  // name : id

int main(int argc, array argv) {
   argv[1] = (run("git", "rev-parse", argv[1])/"\n")[0];
   if (argc==2)
      argv += ({"master"});
   branchnames = git_refs(argv[2..]);
   if (sizeof(branchnames)==0)
      die("refs not found:%{ \"%s\"%}\n", "", argv[2..]);
   foreach (branchnames; string b; string v)
      livebranches[v] += ([b:v]);
   array commit_list = parsecommits("^"+argv[1], @indices(livebranches));
   commit_list = reverse(commit_list);
   desc[argv[1]] = 1;
   foreach (commit_list, string id) {
      if (commits[id]["parent"]) {
         foreach (commits[id]["parent"], string parent)
            if (desc[parent])
                desc[id] = 1;
         if (sizeof(commits[id]["parent"])>1)
            if (!desc[commits[id]["parent"][0]]) {
               int comtime = (int)commits[id]["committer"][-2];
               write("%.12s %-56.56s %.12s\n", id,
                      squeeze_subject(commits[id][""][1]),
                      cal->Second(comtime)->format_time_xshort());
            }
         if (mapping reached = commits[id]["Branch"]) {
            reached = reached&branchnames;
            if (sizeof(reached)>0) {
               branchnames -= reached;
	       array refs = Array.sort_array(indices(reached));
               write("          \\_ Merged into %s [%s]\n",
	               String.implode_nicely(refs),
		       git_describe(id) );
               if (sizeof(branchnames)==0)
                  exit(0);
            }
         }
      }
      m_delete(commits, id);
   }
   array refs = Array.sort_array(indices(branchnames));
   write("             Not reachable from %s\n", String.implode_nicely(refs));
}

// This can slow us down almost twice; open coding it
// into the history walk would be possible, but i'm
// not doing that for only a few 100ms gain (total)...
string git_describe(string id) {
   return (run("git", "describe", id)/"\n")[0];
}

// Given glob pattern(s) ("m?st*r") return a mapping of
// all matching existing refs (symbolic:dereferenced_id)
mapping git_refs(array patterns) {
   mapping res = ([]);
   array tags = ({});

   foreach (patterns; int i; string pattern)
      if (pattern[0..4]!="refs/")
         patterns[i] = "*/"+pattern;
      
   foreach (run("git", "show-ref", "-d")/"\n", string line) {
      array words = line/" ";
      
      if (sizeof(words)<2)
         break;
      foreach (patterns, string pattern)
         if (glob(pattern, words[1]) || glob(pattern+"/*", words[1])) {
            if (words[1][0..9]!="refs/tags/")
               res += ([ words[1] : words[0] ]);
            else
               tags += ({words[1]});
            break;
         }
   }
   
   if (sizeof(tags)) {
      foreach (run("git", "show-ref", "-d", @tags)/"\n", string line)
         if (line[sizeof(line)-3..]=="^{}") {
            array words = line/" ";
            res += ([ words[1][..sizeof(words[1])-4] : words[0] ]);
         }
   }
   
   string prefix = String.common_prefix(indices(res));
   if (prefix!="") {
      int preflen = sizeof(prefix);
      while (preflen && prefix[preflen-1]!='/')
         preflen--;
      foreach (res; string in; string val)
         res[in[preflen..]] = m_delete(res, in);
   }
   return res;
}

string squeeze_subject(string subject) {

   subject = String.trim_all_whites(subject);
   subject = String.expand_tabs(subject);
   foreach (sub_from_to, mapping m)
      subject = replace(subject, m);
   return subject;
}

static array(mapping) sub_from_to =
({
   ([ 
      "Merge branch " : "Merge ",
      "Merge remote branch " : "Merge ",
      "Merge branches " : "MM:",
   ]),
   ([ 
      "Merge " : "M: ",
      "' of git:": "'@git:",
      "' into ": "' => ",
   ]),
   ([ 
       "git://git.kernel.org/pub/scm/linux/kernel/git/" : "$KO/",
       "commit '" : "C'"
   ]),
});

string run(string ... cmdline) {
#if __REAL_MAJOR__<7 || __REAL_MAJOR__==7 && __REAL_MINOR__<8
   string s = Process.popen(cmdline*" ");
   if (s=="")
      die("\n", cmdline*" ");
   return s;
#else
   mapping r;
   mixed e = catch { r = Process.run( ({@cmdline}) ); };
   if (e || r["exitcode"])
      die("", e?e:r["stderr"]);
   return r["stdout"];
#endif
}

static object cal = Calendar.ISO.set_timezone(Calendar.Timezone.UTC);
----------------------------------------------------------------------
