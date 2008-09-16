From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 10:12:44 +0200
Message-ID: <48CF6A7C.4020604@gnu.org>
References: <48CF5127.5040507@gnu.org> <48CF5ABC.5060507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 10:13:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfVh6-0004Cz-4U
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 10:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYIPIMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 04:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbYIPIMq
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 04:12:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:39176 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbYIPIMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 04:12:44 -0400
Received: by ug-out-1314.google.com with SMTP id k3so15526ugf.37
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=meLEtQHwky0Ene2wA1X5Svn3RJbVLmx3Y78bd/s/Tic=;
        b=HHGA7K9HMJIHljpXP3hWniW2gSdrqk+2UqWO20UYv7e9LzRdZ7Sffi1VSd5M40uZ1t
         1rLZAbiCE4Gh0FBqMLCql9oYXjnYQ3RHFOuNz3oq2YolGjFgdDUgkE0MSMaabzC+fbG4
         cmhbzwvQ+B+NE2pljH5KLN04QhyOR6MLou4j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=OB8nhi1eM3fyMlAt5SLS6qff3DvpCP2T8sp6lG7IfQelJ+qgbgByIaG87fGhlZBgs5
         29Vi9rgaPzauVRjtnJV7wezG4Nmx9Wj04y7zaIygvqtyRWSlLJQe2O5Yx3dAffwi/4J7
         wiyPALKcRIWYlBRu263YQbThvhWvT1teUuFSY=
Received: by 10.86.89.1 with SMTP id m1mr456908fgb.68.1221552762115;
        Tue, 16 Sep 2008 01:12:42 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id d6sm16163984fga.2.2008.09.16.01.12.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 01:12:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <48CF5ABC.5060507@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95990>


> With regards to
> 
>> And maybe -b,-qq,-X and -q,-r respectively could be added by default?
>>
>>   
> I would prefer not to do so:  if you do you get something that is
> somehow "specialised", otherwise you have a totally generic "rezipper"
> that might also find other applications (who knows).

Yeah, but regarding -b/-X, their effect can/should be undone with zip
command line options (-l, -ll, -X).  And for zip's -r option, a rezipper
that by default only rezips the top directory does not seem very useful. :-)

You're right about letting the user specify -qq/-q.  Or maybe you can
have a -q/--quiet option to rezip that adds both -qq to unzip, and -q to
zip.  This way you can use the openoffice profile both in quiet mode
(for git) and in non-quiet mode (for manual use).

Putting all of this together, it would make the filter look like this:

  [filter "opendocument"]
        clean = "rezip --quiet --zip-opts -D,-0"
        smudge = "rezip --quiet --zip-opts -D,-6"

or similarly with profiles:

  [filter "opendocument"]
        clean = "rezip --quiet -p ODF_UNCOMPRESS"
        smudge = "rezip --quiet -p ODF_COMPRESS"

After my signature you can find my attempt at making rezip more useful
as a general program.  It supports --quiet, multiple input files, and -
for stdin.  (And I learnt from you that >&$foo works).

> BTW, that is why I added the profiles, so that there was no need to type
> repetitive stuff.

Understood.

Paolo

-----8<-----------------------
#! /bin/sh
#
# (c) 2008 Sergio Callegari
#
# Rewrites a zip archive, possibly changing the compression level

USAGE='Usage: rezip OPTIONS FILE...
with options:
  -h, --help               Gives help
  --unzip-opts OPTIONS     Pass options to unzip helper to read zip file
  --zip-opts OPTIONS       Pass options to zip helper to write zip file
  -p, --profile PROFILE    Get options for helpers from profile
  -q, --quiet              Make unzip and zip quiet

Rewrites a zip archive, possibily changing the compression level.
If the archive name is unspecified or "-", then the command operates
like a filter, reading from standard input and writing to standard
output.  Options (either space- or comma-separated) can be manually
provided to the unzip process doing the read and to the zip process
doing the write.  Alternatively a profile can be used to set options
automatically.'

PROFILES="ODF_UNCOMPRESS ODF_COMPRESS"

PROFILE_UNZIP_ODF_UNCOMPRESS=
PROFILE_ZIP_ODF_UNCOMPRESS=-D,-0
PROFILE_UNZIP_ODF_COMPRESS=
PROFILE_ZIP_ODF_COMPRESS=-D,-6

die()
{
    echo "$3$USAGE

Available profiles: ${PROFILES}" >&$1
    exit $2
}

UNZIP_OPTS=""
ZIP_OPTS=""

while true ; do
    case "$1" in
        -h | --help)
            die 1 0 ;;

        # TODO: handle -p*, --profile=* and similarly for other options

        -p | --profile)
            eval UNZIP_OPTS=\$PROFILE_UNZIP_$2
            eval ZIP_OPTS=\$PROFILE_ZIP_$2
            shift ;;
        --unzip-opts)
            UNZIP_OPTS="${UNZIP_OPTS} $2"
            shift ;;
        --zip-opts)
            ZIP_OPTS="${ZIP_OPTS} $2"
            shift ;;
        -q | --quiet)
            UNZIP_QUIET=-qq
            ZIP_QUIET=-q ;;
        -*)
            die 2 1 "Invalid option: $1
" ;;
        *)
            break ;;
    esac
    shift
done

UNZIP_OPTS="$UNZIP_QUIET -b -X `echo $UNZIP_OPTS | sed 'y/,/ /'`"
ZIP_OPTS="$ZIP_QUIET -r `echo $ZIP_OPTS | sed 'y/,/ /'`"

if [ $# = 0 ] ; then
    set fnord -
    shift
fi

redir=1
for filename
do
    if [ "$filename" = - ]; then
        redir=2
        break
    fi
done

for filename
do
    workdir=`mktemp -d -t rezip.workdir.XXXXXX`

    if [ "$filename" = - ]; then
        tmpcopy=:
        filename=`mktemp rezip.zip.XXXXXX`
        cat > $filename
    else
        tmpcopy=false
    fi

    (case $filename in
        /*) ;;
        *) filename=`pwd`/$filename ;;
    esac
    cd "$workdir"
    unzip $UNZIP_OPTS "$filename" >&$redir
    zip $ZIP_OPTS "$filename" . >&$redir)
    rm -fr "$workdir"

    if $tmpcopy ; then
        cat "$filename"
        rm "$filename"
    fi
done

--------8<------------------------
