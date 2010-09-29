From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [msysGit] Re: Pull request for msysGit patches
Date: Tue, 28 Sep 2010 22:01:42 -0400
Message-ID: <4CA29E06.705@sunshineco.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 04:02:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0lzX-0007uc-CS
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 04:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab0I2CBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 22:01:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58532 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0I2CBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 22:01:49 -0400
Received: by gwj17 with SMTP id 17so120931gwj.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 19:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=VK5IRBhvhFG4jDszzPy8EbONu0IFZeyeFqjCut5arRU=;
        b=l9pn4CQZ14NWdBy3SYCVtvYvcV5WDtuQcmL2+J9jnLrEtE9I7L3EoAhSNpXk56SXev
         c5lAi3B+Vz7gHaBOw+d8mCT4RIw9iDD++jcmupGXGnI6WvpnVUrgm/jErC9HZN+pkWfr
         L2h/isajTfufhYaBEJShqtav2FUCSV53u3zEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=h0HAXXOAd2htQyP15RlGBrVEwS1/I/aD/BajW6DlLxiw9MHFNXIMM2li5RV/MxjSf2
         bqgDgRz0Bu2/CpXTm1oj0FbCnzQqbT3hYPVdk3MJq8cRsA66faGYonVES79nwSwv4HDJ
         sY1CYKDw6S8aWb8fL1LGeaD1v2IA2KIhH0cko=
Received: by 10.101.138.8 with SMTP id q8mr954952ann.164.1285725705410;
        Tue, 28 Sep 2010 19:01:45 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id c7sm9195435ana.38.2010.09.28.19.01.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 19:01:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157520>

Hi Junio,

On 9/28/2010 3:10 PM, Junio C Hamano wrote:
> Pat Thoyts<patthoyts@users.sourceforge.net>  writes:
>> Junio,
>> The msysGit tree currently tracks some 50+ patches on top of 'next'. I
>> have gathered 42 of these that look good to move upstream.
>
> A quick and superficial review follows.
> ----------------------------------------------------------------
> abspath.c
>
> @@ -108,10 +108,15 @@ const char *make_nonrelative_path(const char *path)
>   		if (strlcpy(buf, path, PATH_MAX)>= PATH_MAX)
>   			die("Too long path: %.*s", 60, path);
>   	} else {
> +		size_t len;
> +		const char *fmt;
>   		const char *cwd = get_pwd_cwd();
>   		if (!cwd)
>   			die_errno("Cannot determine the current working directory");
> -		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path)>= PATH_MAX)
> +		len = strlen(cwd);
> +		/* For cwd c:/, return c:/foo rather than URL-like c://foo */
>
> For the patch to be regression free, the logic described by this comment
> requires get_pwd_cmd() to return a string with trailing dir-sep only at
> slash.  IOW, if you see any non-root path returned with a trailing dir-sep
> for whatever reason, you are changing the behaviour in that case as well,
> and that clearly is not "fix at the root level".
> But if you label this as "avoid duplicated dir-sep", everything flows
> smoothly ;-).

I am the author of this patch. Do I understand correctly that your 
primary concern is that you find the comment misleading? I consider the code

   fmt = (len > 0 && is_dir_sep(cwd[len-1])) ? "%s%s" : "%s/%s";

sufficiently self-documenting that the comment is superfluous, and would 
be happy to remove the comment. Would you prefer the patch submitted 
with the comment removed?

-- ES
