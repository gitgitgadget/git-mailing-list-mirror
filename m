From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH 2/3] git-p4: support exclude paths
Date: Sun, 3 Feb 2008 19:41:16 +0100
Message-ID: <200802031941.17010.simon@lst.de>
References: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws> <dd96ea0b47e8ec67ef14e4e954aa9ec7bec3c295.1202029604.git.tommy-git@thorn.ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1483529.FYO1TtLJyY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Sun Feb 03 19:41:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLjmm-0005Aw-7X
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 19:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbYBCSlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 13:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbYBCSlP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 13:41:15 -0500
Received: from hoat.troll.no ([62.70.27.150]:42214 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbYBCSlO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 13:41:14 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Feb 2008 13:41:14 EST
Received: from localhost (localhost [127.0.0.1])
	by hoat.troll.no (Postfix) with ESMTP id 1DFD058076;
	Sun,  3 Feb 2008 19:40:31 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1])
 by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP
 id 16631-03; Sun,  3 Feb 2008 19:40:30 +0100 (CET)
Received: from luria.local (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id B100158074;
	Sun,  3 Feb 2008 19:40:30 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20080118.763038)
In-Reply-To: <dd96ea0b47e8ec67ef14e4e954aa9ec7bec3c295.1202029604.git.tommy-git@thorn.ws>
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72389>

--nextPart1483529.FYO1TtLJyY
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 03 February 2008 10:21:05 Tommy Thorn wrote:
> Teach git-p4 about the -/ option which adds depot paths to the exclude
> list, used when cloning. The option is chosen such that the natural
> Perforce syntax works, eg:
>
>   git p4 clone //branch/path/... -//branch/path/{large,old}/...
>
> Trailing ... on exclude paths are optional.
>
> This is a generalization of a change by Dmitry Kakurin (thanks).
>
> Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>

Acked-By: Simon Hausmann <simon@lst.de>

I like it, Perforce'ish syntax. (Not that I like p4 though ;)


Simon

> ---
>  contrib/fast-import/git-p4 |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 553e237..2340876 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -876,18 +876,25 @@ class P4Sync(Command):
>          self.keepRepoPath = False
>          self.depotPaths = None
>          self.p4BranchesInGit = []
> +        self.cloneExclude = []
>
>          if gitConfig("git-p4.syncFromOrigin") == "false":
>              self.syncWithOrigin = False
>
>      def extractFilesFromCommit(self, commit):
> +        self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
> +                             for path in self.cloneExclude]
>          files = []
>          fnum = 0
>          while commit.has_key("depotFile%s" % fnum):
>              path =  commit["depotFile%s" % fnum]
>
> -            found = [p for p in self.depotPaths
> -                     if path.startswith (p)]
> +            if [p for p in self.cloneExclude
> +                if path.startswith (p)]:
> +                found = False
> +            else:
> +                found = [p for p in self.depotPaths
> +                         if path.startswith (p)]
>              if not found:
>                  fnum = fnum + 1
>                  continue
> @@ -1658,13 +1665,23 @@ class P4Clone(P4Sync):
>          P4Sync.__init__(self)
>          self.description = "Creates a new git repository and imports from
> Perforce into it" self.usage = "usage: %prog [options]
> //depot/path[@revRange]" -        self.options.append(
> +        self.options += [
>              optparse.make_option("--destination", dest="cloneDestination",
>                                   action='store', default=None,
> -                                 help="where to leave result of the
> clone")) +                                 help="where to leave result of
> the clone"), +            optparse.make_option("-/", dest="cloneExclude",
> +                                 action="append", type="string",
> +                                 help="exclude depot path")
> +        ]
>          self.cloneDestination = None
>          self.needsGit = False
>
> +    # This is required for the "append" cloneExclude action
> +    def ensure_value(self, attr, value):
> +        if not hasattr(self, attr) or getattr(self, attr) is None:
> +            setattr(self, attr, value)
> +        return getattr(self, attr)
> +
>      def defaultDestination(self, args):
>          ## TODO: use common prefix of args?
>          depotPath = args[0]
> @@ -1688,6 +1705,7 @@ class P4Clone(P4Sync):
>              self.cloneDestination = depotPaths[-1]
>              depotPaths = depotPaths[:-1]
>
> +        self.cloneExclude = ["/"+p for p in self.cloneExclude]
>          for p in depotPaths:
>              if not p.startswith("//"):
>                  return False

--nextPart1483529.FYO1TtLJyY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHpgrMWXvMThJCpvIRAsNxAJ97n6F7nDrtgkR0ckNYU12BnQ0WpQCeKuDG
+azwEdFh5ja9ziuGXbnoQA0=
=OLpm
-----END PGP SIGNATURE-----

--nextPart1483529.FYO1TtLJyY--
