From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH 4/4] git-ack: record an ack
Date: Wed, 04 Jun 2014 01:53:22 +0200
Message-ID: <538E5FF2.2080506@gmail.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com> <1400447743-18513-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 01:53:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WryWJ-0000Qc-RZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 01:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934144AbaFCXx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 19:53:28 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:49844 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235AbaFCXx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 19:53:27 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3998335lab.31
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VYFYUyfUBT8naKHtqQ47jHdfFTGeV2dCjeOq2xaI+zk=;
        b=BPlrQwJ9yYd3uWcpzwDjioNn1fE6q+W5bdTZUrYHV4ZjQC9Hw+b9wN8uYJZd6KXPGX
         1lLHRlaSgr3xtU1FWYiNptWAixTUxYoFEwqPAPqaZ1BUs8LrtKclw9M1Fts2ht+zsxsE
         CC5CAdfsZXYJNlt4aW5vijwsM1cCvfKDUlLM6tA2dZetUV2rZl6KPX/UoP9+zkvC6kqG
         xmy0R8Kt6Ju2upzbn3q/j5R2QBs4eKVIQv+c7IpXwx5Y+jA2hm4i2XAP3BmirZbpxl3G
         y5YbK0uGoitG2V6LqNH4BSc4JxsmMaADtUkoq6ygnbMkVg2yqnGtOoCZALh35ariI2Gh
         9AJQ==
X-Received: by 10.152.7.37 with SMTP id g5mr37146963laa.14.1401839605531;
        Tue, 03 Jun 2014 16:53:25 -0700 (PDT)
Received: from client.googlemail.com (c80-217-232-187.bredband.comhem.se. [80.217.232.187])
        by mx.google.com with ESMTPSA id ar1sm684193lbc.3.2014.06.03.16.53.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 16:53:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1400447743-18513-5-git-send-email-mst@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250708>

Hi Michael,

I have some inline comments below. Also, some parts of the patch do not
adhere to the style rules

 - tabs for indentation
 - $(...) for command substitution
 - no space after redirection operators
 - double-quotes around redirection targets

for shell scripts (from the file `Documentation/CodingGuidelines`).

On 05/18/2014 11:17 PM, Michael S. Tsirkin wrote:
> diff --git a/contrib/git-ack b/contrib/git-ack
> new file mode 100755
> index 0000000..4aeb16a
> --- /dev/null
> +++ b/contrib/git-ack
> @@ -0,0 +1,84 @@
> +msg=`mktemp`
> +patch=`mktemp`
> +info=`git mailinfo $msg $patch`
> +subj=`echo "$info"|sed -n 's/^Subject: //p'`
> +author=`echo "$info"|sed -n 's/^Author: //p'`
> +email=`echo "$info"|sed -n 's/^Email: //p'`
> +auth="$author <$email>"
> +date=`echo "$info"|sed -n 's/^Date: //p'`
> +sign=`mktemp`
> +echo "ack! $subj" > $sign
> +echo "" >> $sign
> +if
> +    git diff --cached HEAD

If I am not mistaken, the exit code of `git-diff(1)` doesn't change
according to whether there are differences or not, unless the option
`--exit-code` is given.

> +then
> +    nop < /dev/null

Is it correct that this is a do-nothing operation? Is that a common
idiom? I found the null command (`:`, colon) to be used in many places
instead.

> +else
> +    echo "DIFF in cache. Not acked, reset or commit!"
> +    exit 1
> +fi
> +GIT_DIR=`pwd`/${GIT_DIR}

This seems incorrect to me. If `GIT_DIR` is already set, it might point
to an absolute path and not `.git`. If the environment variable is not
set, the state file `ACKS` ends up in the working directory.

Maybe `git-sh-setup(1)` can be of help. It uses

    git rev-parse --git-dir

to probe the path to the .git directory.

> +
> +usage () {
> +	echo "Usage: git ack " \
> +            "[-s|--save|-a|--append|-r|--restore |-c|--clear]\n" >& 2;
> +        exit 1;
> +}
> +
> +append=
> +save=
> +clear=

The restore flag seems to be missing from this list of declarations.

> +
> +while test $# != 0
> +do
> +	case "$1" in
> +	-a|--append)
> +		append="y"
> +		;;
> +	-s|--s)
> +		save="y"
> +		;;
> +	-r|--restore)
> +		restore="y"
> +		;;
> +	-c|--clear)
> +		clear="y"
> +                ;;
> +	*)
> +		usage ;;
> +	esac
> +	shift
> +done
> +
> +if
> +    test "$clear"
> +then
> +    rm -f "${GIT_DIR}/ACKS"
> +fi
> +
> +if
> +    test "$save"
> +then
> +    if
> +        test "$append"
> +    then
> +        cat $msg >> "${GIT_DIR}/ACKS"
> +    else
> +        cat $msg > "${GIT_DIR}/ACKS"
> +    fi
> +fi
> +
> +if
> +    test "$restore"
> +then
> +    msg = ${GIT_DIR}/ACKS
> +fi
> +
> +if
> +    grep '^[A-Z][A-Za-z-]*-by:' $msg >> $sign
> +then
> +    git commit --allow-empty -F $sign --author="$auth" --date="$date"
> +else
> +    echo "No signature found!"
> +    exit 2
> +fi

   Fabian
