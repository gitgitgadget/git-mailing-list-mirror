From: Joey Hess <joey@kitenet.net>
Subject: git-union-merge proposal
Date: Mon, 20 Jun 2011 22:20:49 -0400
Message-ID: <20110621022049.GA1632@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 04:21:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYqag-0000dn-OD
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 04:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab1FUCU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 22:20:59 -0400
Received: from wren.kitenet.net ([80.68.85.49]:53127 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab1FUCU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 22:20:58 -0400
Received: from gnu.kitenet.net (dialup-4.154.1.215.Dial1.Atlanta1.Level3.net [4.154.1.215])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id C9FD5118120
	for <git@vger.kernel.org>; Mon, 20 Jun 2011 22:20:54 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id E5E384DE39; Mon, 20 Jun 2011 22:20:49 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176119>


--dc+cDN39EJAMEtIO
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lately some tools are storing data in git branches or refs, that is not
source code, and that is designed in some way to be automatically
merged. Generally merge=3Dunion will work for it, but the problem is that
git-merge can only operate on the checked out branch, not other
branches.

So these things all deal with merging in their own ad-hoc ways:

* pristine-tar commits the info it needs to reconstruct tarballs
  to a pristine-tar branch; files in the branch should not easily conflict
  as each includes the name of the tarball.. but when git pull
  cannot fast-forward the pristine-tar branch, the user is left to
  manually fix it.
* git-annex stores location tracking information to log files in
  .git-annex/; gitattributes is configured to use merge=3Dunion,
  and the log files have timestamps or are otherwise structured to be
  safely merged.
* git notes merge -s cat_sort_uniq
  Notes are stored in a tree using the object sha, which can be
  union merged, when the notes' format is a series of independant lines.
* probably other tools do things like this too, or will ...

So I've written a prototype of a git-union-merge that could be used
for all of these. It works like this:

git union-merge foo origin/foo refs/heads/foo=20

That looks up foo and origin/foo and union merges them together,
producing the new branch refs/heads/foo. New blobs are injected
as needed for unioned files, and the merge commit is generated,
without affecting the current working tree, and without any
expensive checkouts of the branches. It's pretty fast, it only
needs to write out a temporary index file.

Prototype is attached, I doubt it would be suitable for git as-is,
but it does show how this is accomplished, if you've not already
seen how to do it -- just look for ls-tree, diff-tree,
show, hash-object, and update-index. Note that merging file modes is
not yet dealt with.

I imagine a git that can have union merge or other custom automated
merge strategies configured on a per-branch basis, so that git pull
automatically merges branches. That could be a good basis for adding
Fossil-like features to git.

--=20
see shy jo

--n8g4imXOkfNTN/H1
Content-Type: text/x-haskell; charset=us-ascii
Content-Disposition: attachment; filename="git-union-merge.hs"
Content-Transfer-Encoding: quoted-printable

{- git-union-merge program
 -
 - Copyright 2011 Joey Hess <joey@kitenet.net>
 -
 - Licensed under the GNU GPL version 3 or higher.
 -}

import System.Environment
import System.FilePath
import System.Directory
import System.Cmd.Utils
import System.Posix.Env (setEnv)
import Control.Monad (when)
import Data.List
import Data.Maybe
import Data.String.Utils

import qualified GitRepo as Git
import Utility

header :: String
header =3D "Usage: git-union-merge ref ref newref"

usage :: IO a
usage =3D error $ "bad parameters\n\n" ++ header

main :: IO ()
main =3D do
	[aref, bref, newref] <- parseArgs
	g <- setup
	stage g aref bref
	commit g aref bref newref
	cleanup g

parseArgs :: IO [String]
parseArgs =3D do
	args <- getArgs
	if (length args /=3D 3)
		then usage
		else return args

tmpIndex :: Git.Repo -> FilePath
tmpIndex g =3D Git.workTree g </> Git.gitDir g </> "index.git-union-merge"

{- Configures git to use a temporary index file. -}
setup :: IO Git.Repo
setup =3D do
	g <- Git.configRead =3D<< Git.repoFromCwd
	cleanup g -- idempotency
	setEnv "GIT_INDEX_FILE" (tmpIndex g) True
	return g

cleanup :: Git.Repo -> IO ()
cleanup g =3D do
	e' <- doesFileExist (tmpIndex g)
	when e' $ removeFile (tmpIndex g)

{- Stages the content of both refs into the index. -}
stage :: Git.Repo -> String -> String -> IO ()
stage g aref bref =3D do
	-- Get the contents of aref, as a starting point.
	ls <- fromgit
		["ls-tree", "-z", "-r", "--full-tree", aref]
	-- Identify files that are different between aref and bref, and
	-- inject merged versions into git.
	diff <- fromgit
		["diff-tree", "--raw", "-z", "-r", "--no-renames", "-l0", aref, bref]
	ls' <- mapM mergefile (pairs diff)
	-- Populate the index file. Later lines override earlier ones.
	togit ["update-index", "-z", "--index-info"]
		(join "\0" $ ls++catMaybes ls')
	where
		fromgit l =3D Git.pipeNullSplit g (map Param l)
		togit l content =3D Git.pipeWrite g (map Param l) content
			>>=3D forceSuccess
		tofromgit l content =3D do
			(h, s) <- Git.pipeWriteRead g (map Param l) content
			length s `seq` do
				forceSuccess h
				Git.reap
				return ((), s)

		pairs [] =3D []
		pairs (_:[]) =3D error "parse error"
		pairs (a:b:rest) =3D (a,b):pairs rest
	=09
		nullsha =3D take shaSize $ repeat '0'
		ls_tree_line sha file =3D "100644 blob " ++ sha ++ "\t" ++ file
		unionmerge =3D unlines . nub . lines
	=09
		mergefile (info, file) =3D do
			let [_colonamode, _bmode, asha, bsha, _status] =3D words info
			if bsha =3D=3D nullsha
				then return Nothing -- already staged from aref
				else mergefile' file asha bsha
		mergefile' file asha bsha =3D do
			let shas =3D filter (/=3D nullsha) [asha, bsha]
			content <- Git.pipeRead g $ map Param ("show":shas)
			sha <- getSha "hash-object" $
				tofromgit ["hash-object", "-w", "--stdin"] $
					unionmerge content
			return $ Just $ ls_tree_line sha file

{- Commits the index into the specified branch. -}
commit :: Git.Repo -> String -> String -> String -> IO ()
commit g aref bref newref =3D do
	tree <- getSha "write-tree"  $
		pipeFrom "git" ["write-tree"]
	sha <- getSha "commit-tree" $
		pipeBoth "git" ["commit-tree", tree, "-p", aref, "-p", bref]
			"union merge"
	Git.run g "update-ref" [Param newref, Param sha]

{- Runs an action that causes a git subcommand to emit a sha, and strips
   any trailing newline, returning the sha. -}
getSha :: String -> IO (a, String) -> IO String
getSha subcommand a =3D do
	(_, t) <- a
	let t' =3D if last t =3D=3D '\n'
		then take (length t - 1) t
		else t
	when (length t' /=3D shaSize) $
		error $ "failed to read sha from git " ++ subcommand ++ " (" ++ t' ++ ")"
	return t'

shaSize :: Int
shaSize =3D 40

--n8g4imXOkfNTN/H1--

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTgAAAckQ2SIlEuPHAQgt7w//VXB23C3OjcQha4Y5UXEV/5/dE1PaBEvZ
cwNiPDGuEXwHTAbBEyflgujPtiYSM39cy5zdBGe17X+Rh9o5Txk6u/LL8H24iUN9
upQJL7VtpcXul0Iru4vepMc6zLqB+etkFs6ct0hZn0iU6ruDYo7EoYm8st2y80xt
BqBVgMvv2FsYS+a+3ImogHgjQqpvU3xrDJpJ7K/hxYwlOtDP7ZsASK+98taHdZjU
Y9GS8+NXJ6x6Seo1ULmZl9ZB/jQVIi3lkRs/sMXWLWRs0/shkvIO5siFTFfbfKQe
SWX66yMHlzledhymjA/C6buxKfkI2ESf8Bz5oJ91sZsnwQZCGzgwWLOM4ap+9UvC
5Zzxg14LxtKm9qwbvRppudA08fKGXvl1gLEiBKEoKcSbMYXDEutPJ7169e4+U1S1
LJ+zAehydxYMS7ghNQq5wdrQ6vWluFZkD3G3Aq4QyVUjA5VX2YbbG+nJOiostiMM
8qkngP/U+PfoDVouwoEQyty9xpTwNRbCsM8eb9xymLhQctoq0YSemXQDpQrmShlx
DCg1Bo2EhU9yWx+oqJby8tJjI796iEiUI+WJKG8uJV9v3pGngy9VPMPdCy7XlzpP
a7IwVt/gqUFSeBbYMah2GhNfMIDwphp9d9r81MfihsB78OBfESwbl0hYs7o095UI
VuJqA+oP87w=
=c2JV
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
