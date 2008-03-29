From: CJ van den Berg <cj@vdbonline.com>
Subject: Re: git-archive and submodules
Date: Sat, 29 Mar 2008 22:05:58 +0100
Message-ID: <20080329210557.GA4837@prefect.vdbonline.net>
References: <8ec76080803290647h25e86f18k7a86bc4cb2cc3d38@mail.gmail.com> <20080329135202.GR4759@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 22:17:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfiQG-0000iZ-Ke
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 22:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbYC2VQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 17:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbYC2VQZ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 17:16:25 -0400
Received: from marvin.vdbonline.net ([208.78.101.188]:50999 "EHLO
	marvin.vdbonline.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbYC2VQY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 17:16:24 -0400
X-Greylist: delayed 622 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Mar 2008 17:16:24 EDT
Received: from prefect.vdbonline.net (localhost [127.0.0.1])
	by marvin.vdbonline.net (Postfix) with ESMTPSA id 4E92E6805B;
	Sat, 29 Mar 2008 22:06:01 +0100 (CET)
Received: by prefect.vdbonline.net (Postfix, from userid 1000)
	id 688531A8338; Sat, 29 Mar 2008 22:05:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080329135202.GR4759@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78482>


--tsOsTdHNUZQcU9Ye
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2008 at 09:52:02AM -0400, Shawn O. Pearce wrote:
> Whit Armstrong <armstrong.whit@gmail.com> wrote:
> > Is there a way to ask git-archive to archive the submodules of the
> > project as well?
> >=20
> > I have a project that needs it's submoduels distributed with it.
>=20
> No.
>=20
> Patches welcome.  :-)
> =20
> We've talked about supporting it, and wouldn't mind having the
> tool do it for exactly the reason you mention, but thus far a
> patch has not been written to implement that.

Here's a script I use at work that calls git-archive recursively for
submodules and builds a single tarball for everything. If there is
interest in having something like this in git proper I could put some
work into cleaning it up for general use. Perhaps something like this
should be integrated into git-archive directly. Comments and suggestions
are welcome.

--=20
CJ van den Berg

mailto:cj@vdbonline.com
  xmpp:cj@vdbonline.com

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-archive-recursive

#!/bin/bash

set -e

TMP_DIR=$(mktemp -t -d $(basename $0).$USER.XXXXX)
GITMODULES_FILE=${TMP_DIR}/gitmodules
THIS_TAR=${TMP_DIR}/this.tar
SUBMODULE_TAR=${TMP_DIR}/submodule.tar

function cleanup() {
        rm -rf $TMP_DIR
}

function die() {
        cleanup
                exit 1
}

trap die SIGINT
trap die SIGHUP
trap die SIGTERM
trap die SIGQUIT
trap die ERR
trap cleanup EXIT

function usage() {
    echo "Build an archive of a repository and all submodules." >&2
    echo "" >&2
    echo "usage: $(basename $0) [-r n] repo treeish [prefix]" >&2
    echo "  repo      Repository path or URL." >&2
    echo "  treeish   Version to archive." >&2
    echo "  -r n      Maximum recursion level. Default is 1." >&2
    echo "  -h        Show this message." >&2
    echo "" >&2
    exit 1
}

while [ "${1:0:1}" == "-" ]
do
    if [ "$1" == "-h" ] ; then
        usage
    fi
    if [ "$1" == "-r" ] ; then
        LEVEL=$2
        shift
        if [ -z "$LEVEL" ] ; then
            usage
        fi
        if [ ! $LEVEL -lt 0 ] ; then
            echo -n "" >&2
        else
            usage
        fi
    fi
    shift
done

if [ $# -lt 2 -o $# -gt 3 ] ; then
    usage
fi

export GIT_DIR=$1
REV="$2"
PREFIX="$3"
if [ -z "$LEVEL" ] ; then
    LEVEL=1
fi

if echo $GIT_DIR | grep -q ":"
then
    REMOTE_HOST=$(echo $GIT_DIR | cut -d ":" -f 1)
    REMOTE_PATH=$(echo $GIT_DIR | cut -d ":" -f 2)
    if [ "$REMOTE_HOST" == "$(hostname)" ] ; then
        export GIT_DIR=${REMOTE_PATH}
    else
        exec ssh -n $REMOTE_HOST $(basename $0) -r $LEVEL $REMOTE_PATH $REV $PREFIX
    fi
fi

if [ "${GIT_DIR:0:2}" == "~/" ] ; then
    export GIT_DIR=/home/${USER}/${GIT_DIR#\~/}
elif [ "${GIT_DIR:0:1}" == "~" ] ; then
    export GIT_DIR=/home/${GIT_DIR#\~}
fi

REV_NAME=$(git describe ${REV} 2> /dev/null || true)
if [ -z "$REV_NAME" ] ; then
    REV_NAME=$(git rev-parse ${REV})
fi

if [ -z "$PREFIX" ] ; then
    PREFIX=$REV_NAME
fi

echo >&2 ${PREFIX} from $(git-make-repo-url) \(${REV_NAME}\)
git archive --prefix=${PREFIX}/ $REV > $THIS_TAR

mkdir -p $TMP_DIR/$PREFIX
echo ${REV_NAME}> $TMP_DIR/$PREFIX/GITVERSION
echo $(git-make-repo-url)> $TMP_DIR/$PREFIX/GITSOURCE
(
    cd $TMP_DIR
    tar -rf $THIS_TAR $PREFIX
)

if [ $LEVEL -gt 0 ]
then
    if git show $REV:.gitmodules > $GITMODULES_FILE 2> /dev/null
    then
        LEVEL=$(($LEVEL - 1))
        git ls-tree -r "$REV" | grep '^160000 ' |
        while read mode type sha1 path
        do
            (
            submodule_name=$(git config --file $GITMODULES_FILE --list | \
                              grep "^submodule\..*\.path=$path" | cut -d . -f 2)
            if [ -z "$submodule_name" ] ; then
                echo >&2 -n "fatal: No submodule mapping found in .gitmodules "
                echo >&2    "for path '$path'"
                exit 1
            fi
            url=$(git config --file $GITMODULES_FILE \
                            submodule."$submodule_name".url || exit 1)
            $(basename $0) -r $LEVEL $url $sha1 $PREFIX/$path > $SUBMODULE_TAR || exit 1
            tar --concatenate --file=$THIS_TAR $SUBMODULE_TAR || exit 1
            ) < /dev/null
        done
    fi
fi
cat $THIS_TAR

--3MwIy2ne0vdjdPXF--

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH7q81l3pZXfh0CHIRAgPiAJ9pHGZMUlz0HI6Cy2LxUY+xtmZ4wACeOPX8
BsyzvBxuwXFxmWiPmGqhnpI=
=cOBG
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
