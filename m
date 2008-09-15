From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Management of opendocument (openoffice.org) files in git
Date: Mon, 15 Sep 2008 22:40:01 +0000 (UTC)
Message-ID: <loom.20080915T222909-709@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:41:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfMlA-0002yY-MF
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 00:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbYIOWkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 18:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbYIOWkO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 18:40:14 -0400
Received: from main.gmane.org ([80.91.229.2]:34574 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756093AbYIOWkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 18:40:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KfMjo-0000hC-VB
	for git@vger.kernel.org; Mon, 15 Sep 2008 22:40:09 +0000
Received: from c-71-197-224-64.hsd1.wa.comcast.net ([71.197.224.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 22:40:08 +0000
Received: from sergio.callegari by c-71-197-224-64.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 22:40:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.197.224.64 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080715 Ubuntu/7.10 (gutsy) Firefox/2.0.0.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95951>

Hi,

Management of opendocument files in git has been discussed a short time ago.
Here is an helper script that may help achieving better density in git packs
containg blobs from openoffice files.

To try it, save the following as "rezip" with execution permission:

-----8<----------------------- 

#! /bin/bash
#
# (c) 2008 Sergio Callegari
#
# Rewrites a zip archive, possibly changing the compression level

USAGE='Usage: rezip [options] [file]
with options:
  [-h | --help]            Gives help
  [-p ?]                   Lists known profiles
  [--unzip_opts options]   Pass options to unzip helper to read zip file
  [--zip_opts options]     Pass options to zip helper to write zip file
  [-p | --profile profile] Get options for helpers from profile

Rewrites a zip archive, possibily changing the compression level.
If the archive name is unspecified, then the command operates like a filter,
reading from standard input and writing to standard output.
Options can be manually provided to the unzip process doing the read and to
the zip process doing the write. Alternatively a profile can be used to set
options automatically.'

PROFILES="ODF_UNCOMPRESS ODF_COMPRESS"

PROFILE_UNZIP_ODF_UNCOMPRESS='-b -qq -X'
PROFILE_ZIP_ODF_UNCOMPRESS='-q -r -D -0'
PROFILE_UNZIP_ODF_COMPRESS='-b -qq -X'
PROFILE_ZIP_ODF_COMPRESS='-q -r -D -6'

die()
{
    echo "$1" >&$2
    exit $3
}

UNZIP_OPTS=""
ZIP_OPTS=""

while true ; do
    case "$1" in
        -h | --help)
            die "$USAGE" 1 0 ;;
        -p | --profile)
            if [ "$2" = "?" ] ; then
                die "Avalilable profiles: ${PROFILES}" 1 0 ;
            else
                profile=$2
                shift
                profile_unzip=PROFILE_UNZIP_${profile}
                profile_zip=PROFILE_ZIP_${profile}
                UNZIP_OPTS=${!profile_unzip}
                ZIP_OPTS=${!profile_zip}
            fi ;;
        --unzip_opts)
            UNZIP_OPTS=${UNZIP_OPTS} $2
            shift ;;
        --zip_opts)
            ZIP_OPTS=${ZIP_OPTS} $2
            shift ;;
        -*)
            die "$USAGE" 2 1 ;;
        *)
            break ;;
    esac
    shift
done

if [ $# = 0 ] ; then
    tmpcopy=$(mktemp rezip.zip.XXXXXX)
    cat > $tmpcopy
    filename="$tmpcopy"
else
    tmpcopy=""
    filename="$1"
fi

workdir=$(mktemp -d -t rezip.workdir.XXXXXX)
curdir=$(pwd)

cd $workdir
unzip $UNZIP_OPTS "$curdir/$filename"
zip $ZIP_OPTS "$curdir/$filename" .
cd $curdir
rm -fr $workdir
if [ ! -z "$tmpcopy" ] ; then
  cat $filename
  rm $tmpcopy
fi

--------8<------------------------

then put in your .git/config something like

[filter "opendocument"]
        clean = "rezip -p ODF_UNCOMPRESS"
        smudge = "rezip -p ODF_COMPRESS"

and finally set gitattributes as

*.odt filter=opendocument
*.ods filter=opendocument
*.odp filter=opendocument

Note:
   with this you might experience some delay on operations like
git status
git add
git commit -a
git checkout

depending on the size of the opendocument files being tracked.

Before using on anything sensitive, please test that it does what it should.

The script should probably be made more robust against unexpected situations.

Hope it can be useful to someone.

Sergio
