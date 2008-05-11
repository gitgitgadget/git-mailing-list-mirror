From: nathan spindel <nathans@gmail.com>
Subject: Re: [PATCH v2] instaweb: make it compatible with Mac OS X 10.5's apache installation.
Date: Sun, 11 May 2008 12:41:46 -0700
Message-ID: <B3990C52-0AF9-490C-86E1-B311144C6661@gmail.com>
References: <1210534569-48466-1-git-send-email-nathans@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nathan spindel <nathans@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 21:42:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvHRg-0004ja-CO
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 21:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbYEKTlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 15:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755514AbYEKTlt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 15:41:49 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:38854 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbYEKTls (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 15:41:48 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2010295wfd.4
        for <git@vger.kernel.org>; Sun, 11 May 2008 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=vbYfqklAVftm7wohNdW19gl60JV7ycpqvW7gR6YevVo=;
        b=XP5LcDT6aswGm961/CTtHLVG0m/AavsOd3pNGPhzK5khiyxxPBsUcBGY9w3Lrc6csQfJ7h8yphmevH3HRp3GNzgHG7tYmYZGtoBz2ZQ/OxVVDge0TFLqVgG+W8nyaeoZszU3VQgMtaNZub7ZtI8VUNAmQF/kzmfc7kTc2EgGkDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=PmN0eFIYFW44AlVE1hAOCK+x1sy/8kZaqY258yFcskvPnjCsicfFhS4Ens31VdE0WnBllrGUJNcNxGfpRqJTRhPdt6j0YHThmN9M0+REumYxmA1SJAxCBwrnrMiAqFR+zTnnIuK8C/nqeTtdlujFI0luQEMpbIByA4ef06tBy7E=
Received: by 10.142.191.2 with SMTP id o2mr2923195wff.209.1210534908129;
        Sun, 11 May 2008 12:41:48 -0700 (PDT)
Received: from ?10.0.1.4? ( [76.14.71.118])
        by mx.google.com with ESMTPS id 27sm15866380wff.7.2008.05.11.12.41.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 12:41:47 -0700 (PDT)
In-Reply-To: <1210534569-48466-1-git-send-email-nathans@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81817>

On May 11, 2008, at 12:36 PM, nathan spindel wrote:

> apache2_conf () {
> -	test -z "$module_path" && module_path=/usr/lib/apache2/modules
> +	# if there isn't an apache2 command on the system but there
> +	# is a httpd command which looks like apache, use that instead
> +	# for Mac OS X compatibility.
> +	httpd_only="`echo $httpd | cut -f1 -d' '`"
> +	if ! type $httpd_only > /dev/null 2>&1
> +	then
> +		found_apache_command=1
> +		httpd_parent_paths="/usr/local/sbin /usr/sbin"
> +		for i in $httpd_parent_paths; do
> +			if test -x "$i/$httpd_only"
> +			then
> +				found_apache_command=0
> +				break
> +			fi
> +		done
> +
> +		if test $found_apache_command != 0
> +		then
> +			alt_apache="httpd"
> +			if type $alt_apache > /dev/null 2>&1
> +			then
> +				$alt_apache -v | grep Apache > /dev/null 2>&1
> +				if test $? == 0
> +				then
> +					httpd=`echo "$httpd" | sed "s/apache2/httpd/"`
> +				else
> +					for i in $httpd_parent_paths; do
> +						if test -x "$i/$alt_apache"
> +						then
> +							$i/$alt_apache -v | grep Apache > /dev/null 2>&1
> +							if test $? == 0
> +							then
> +								httpd=`echo "$httpd" | sed "s/apache2/httpd/"`
> +								break
> +							fi
> +						fi
> +					done
> +				fi
> +			fi
> +		fi
> +	fi

I'd like to see a cleaner implementation of this logic, if anyone has  
strong shell-fu.
