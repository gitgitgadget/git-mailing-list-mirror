From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH] Support different branch layouts in git-p4
Date: Sat, 5 Feb 2011 01:37:54 +0100
Message-ID: <AANLkTi=ozDk9SqYaYWKHXSjVChV-93-88F_LUCwfSiDc@mail.gmail.com>
References: <4D489068.2040704@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ian Wienand <ianw@vmware.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 01:38:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlWA6-0004DJ-3G
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 01:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab1BEAh4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 19:37:56 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63086 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab1BEAh4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 19:37:56 -0500
Received: by yxt3 with SMTP id 3so1145626yxt.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 16:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zBTilXXkjzPs0fr3XfiXUgp32CEeP7gmHJCRvV4X3n0=;
        b=OqqphmMxl3qazMEcRgQXR88pXQ3oYEtkVJEhHeVRSL9q8hRfbTdqFmPd3oUMoO7hDE
         q27Zs0OdGLKHT6KIe/M/YEN+y+jG0rM0LaQNwA92i9qaOUM50PVCKKyO+7BseclKCX6d
         8Q1ZwmPLlI+P5nGYW4b3Hth3zTfI5v937C1Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l6QYQwJSRnAeBlo+UEF4pYCwlDNnqASdbyQdP7r7a9ltkAIqUsrgLdu+ZfMBYHVU+w
         z53X0yYJP34VWnek/yTfxOOB3chB/CV00yvUfE73gDlpmgJaSj+aDKDySFvG6/z7gBDX
         xkWZ3e//WgAURJF1yP8iJ+GV7tVIt/E7+Hyjg=
Received: by 10.101.165.31 with SMTP id s31mr7940716ano.216.1296866274796;
 Fri, 04 Feb 2011 16:37:54 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Fri, 4 Feb 2011 16:37:54 -0800 (PST)
In-Reply-To: <4D489068.2040704@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166066>

On Tue, Feb 1, 2011 at 11:59 PM, Ian Wienand <ianw@vmware.com> wrote:
> Hi,
>
> I think the addition to the git-p4.txt in the diff explains the
> reasoning behind the patch best. =C2=A0In short, we have a repository
> layout
>
> //depot/foo/branch
> //depot/moo/branch
>
> where we require projects 'foo' and 'moo' to be alongside each other.
> We can do this with p4 views, but currently have to have 'foo' and
> 'moo' in separate git repos.
>
> This just munges the incoming paths to either put the branch as the
> top level directory, or just remove it entirely if you don't need it.

Hi, Ian! We haven't met, but thank you for the patch, and for trying
to help make git better.

Now, I have to say that I don't particularly like it, and here's why I
will vote against this patch:

=46or starters, I don't think that I like git-p4 being taught to solve
problems that seem to be caused by a poor/unfortunate perforce layout.
Especially since *your* type of poor perforce layout will probably be
poor in a very different way from the next guy with a poor layout :)
=46or instance, you have hard-coded that you replace the first and
second directory name... It is very easy to imagine people having
deeper trees than that...

But then I started thinking about it a bit more... It was me who added
the --use-client-spec option back in the day. The support for that
stuff really should be better than what I made at the time. The
client-spec format contains lines like

//depot/...   //local-root/...
-//depot/dontcare/...   //local-root/dontcare/...
//depot/foo/branch/...   //local-root/branch/foo/...
//depot/moo/branch/...   //local-root/branch/moo/...

Please observe that the two last lines look like what I think *your*
client-spec should look like. This would map the foo/branch and
moo/branch in the perforce depot to branch/foo and branch/moo on the
client side.

Of course, today this will not work with git-p4 clone. The
--use-client-spec option, as I implemented it, simply filters out all
that stuff that matches the pattern lines that starts with "-". So the
names of all files will match the patterns on the left-hand side in
the client-spec. A solution which I think would work well for
everyone, is if files would be placed according to the right-hand
patterns in the client-spec.

That should be a much more elegant and generic solution. Whatcha
think? If you want to take a whack at hacking that into place, I will
help guide the way if needed (if others are not opposed to such an
idea) :)

    -- Tor Arvid

> I've tested it locally, but I don't really have a wide variety of p4
> environments to expose it too.
>
> -i
>
> Signed-off-by: Ian Wienand <ianw@vmware.com>
> ---
> =C2=A0contrib/fast-import/git-p4 =C2=A0 =C2=A0 | =C2=A0 35 ++++++++++=
+++++++++++++-
> =C2=A0contrib/fast-import/git-p4.txt | =C2=A0 58 ++++++++++++++++++++=
++++++++++++++++++++
> =C2=A02 files changed, 92 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 04ce7e3..4bd40f8 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -848,6 +848,10 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optparse.make=
_option("--max-changes", dest=3D"maxChanges"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optparse.make=
_option("--keep-path", dest=3D"keepRepoPath", action=3D'store_true',
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D"=
Keep entire BRANCH/DIR/SUBDIR prefix during import"),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optparse.mak=
e_option("--branch-path", dest=3D"branchPath", type=3D'choice',
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 choices=3D('no=
ne', 'first'),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D"Remove=
 the branch dir (none) or move it above project dir (first)"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optparse.make=
_option("--use-client-spec", dest=3D"useClientSpec", action=3D'store_tr=
ue',
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D"=
Only sync files that are included in the Perforce Client Spec")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]
> @@ -917,6 +921,20 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if path.startswith(p):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D path=
[len(p):]
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0# reorg to move/remove branch from the o=
utput filename -- kind
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0# of like how you can set your view in y=
our p4 client
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.keepRepoPath and self.branchPath=
 =3D=3D 'first':
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# move the second element =
first, so what was was
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# "//depot/proj/branch/fil=
e" becomes "branch/proj/file".
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D re.sub("^([^/]+/)=
([^/]+/)", r'\2\1', path)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0elif self.keepRepoPath and self.branchPa=
th =3D=3D 'none':
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# remove the second elemen=
t, so what was
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# "//depot/proj/branch/fil=
e" becomes "proj/file"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D re.sub("^([^/]+/)=
([^/]+/)", r'\2', path)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0elif self.branchPath:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stderr.write("branchPa=
th without keepRepoPath?")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return path
>
> =C2=A0 =C2=A0 def splitFilesIntoBranches(self, commit):
> @@ -940,7 +958,6 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 relPath =3D self.stripRepoP=
ath(path, self.depotPaths)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for branch in self.knownBra=
nches.keys():
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # add a trail=
ing slash so that a commit into qt/4.2foo doesn't end up in qt/4.2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if relPath.st=
artswith(branch + "/"):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if branch not in branches:
> @@ -1283,12 +1300,24 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.keepRepoPath:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 option_keys['keepRepoPath']=
 =3D 1
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0# since we're just saving the dict keys,=
 append the branchPath
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0# option to the key
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.branchPath:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0option_keys['branchPath_%s=
' % self.branchPath] =3D 1
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 d["options"] =3D ' '.join(sorted(option_k=
eys.keys()))
>
> =C2=A0 =C2=A0 def readOptions(self, d):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.keepRepoPath =3D (d.has_key('options=
')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and ('keepRepoPath' in d['options'])=
)
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0# restore the branchpath option; is one =
of "none" and "first"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (d.has_key('options')):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ('branchPath_none' in d=
['options']):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.branchP=
ath =3D 'none'
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif ('branchPath_first' i=
n d['options']):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.branchP=
ath =3D 'first'
> +
> =C2=A0 =C2=A0 def gitRefForBranch(self, branch):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if branch =3D=3D "main":
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.refPrefix + "ma=
ster"
> @@ -1775,6 +1804,10 @@ class P4Clone(P4Sync):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.stderr.write("Must spec=
ify destination for --keep-path\n")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.branchPath and not self.keepRepo=
Path:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stderr.write("Must spe=
cify --keep-path for --branch-path\n")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 depotPaths =3D args
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.cloneDestination and len(depo=
tPaths) > 1:
> diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git=
-p4.txt
> index 49b3359..669c63c 100644
> --- a/contrib/fast-import/git-p4.txt
> +++ b/contrib/fast-import/git-p4.txt
> @@ -191,6 +191,64 @@ git-p4.useclientspec
>
> =C2=A0 git config [--global] git-p4.useclientspec false
>
> +Dealing with different repository layouts
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Perforce clients can map views of projects and branches in different
> +ways which your build system may rely on. =C2=A0Say your code is org=
anised
> +as two projects "foo" and "moo" which have a common branch
> +
> +//depot/foo/branch/...
> +//depot/moo/branch/...
> +
> +and you require both "foo" and "moo" projects in your git repository=
,
> +there are several options.
> +
> +Firstly, you could simply clone each project as a completely separat=
e
> +git tree. =C2=A0However, if the two projects are dependent on each o=
ther
> +this can be annoying for both sync -- you must remember to sync both
> +"foo" and "moo" to keep everything consistent -- and submit -- a
> +change that should logically be a single changeset across "foo" and
> +"moo" will have to be broken up (breaking bisection too).
> +
> +Another option is to simply specify multiple depots
> +
> + git p4 sync //depot/foo/branch //depot/moo/branch
> +
> +which will import "foo" and "moo" into the same directory.
> +
> +To keep the projects separate, the --keep-path option used as
> +
> + git p4 sync --keep-path --destination /tmp/boo/ //depot/foo/branch =
//depot/moo/branch
> +
> +will create a layout of
> +
> + /tmp/boo/foo/branch/...
> + /tmp/boo/moo/branch/...
> +
> +However, some build systems may rely on p4's ability to specify
> +destinations for views in your client. =C2=A0The --branch-path flag,=
 which
> +requires the --keep-path flag, allows two additional layout options.
> +
> + git p4 sync --keep-path --destination /tmp/boo --branch-path=3Dnone=
 //depot/foo/branch //depot/moo/branch
> +
> +will remove the branch name entirely, leaving you with a directory
> +that looks like
> +
> + /tmp/boo/foo/...
> + /tmp/boo/moo/...
> +
> +and
> +
> + git p4 sync --keep-path --destination /tmp/boo --branch-path=3Dfirs=
t //depot/foo/branch //depot/moo/branch
> +
> +will give you each of the projects under a directory named for their
> +common branch
> +
> + /tmp/boo/branch/foo/...
> + /tmp/boo/branch/moo/...
> +
> +
> =C2=A0Implementation Details...
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
