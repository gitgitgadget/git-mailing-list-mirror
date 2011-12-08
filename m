From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 1/2] run-command: Add checks after execvp fails with
 EACCES
Date: Thu, 08 Dec 2011 22:44:11 +0100
Message-ID: <op.v56xbxqs0aolir@keputer>
References: <op.v5e8mgbc0aolir@keputer>
 <1323207503-26581-1-git-send-email-fransklaver@gmail.com>
 <1323207503-26581-2-git-send-email-fransklaver@gmail.com>
 <7vpqg1e3au.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 22:44:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYllS-0007Ey-DY
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 22:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab1LHVoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 16:44:19 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33196 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1LHVoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 16:44:16 -0500
Received: by eaak14 with SMTP id k14so1417698eaa.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=txSMvYlB6LcLVhxjFuyGjDFrLgefQF0UbXLIR9tbnaA=;
        b=FTa1gT5F6GnjLXObyt58PKFarDAzH/jHRtUr73qGFEI4gJXxV6i6tlMYOQ0dL0O6yN
         FZhKdQ7DNdcfmlErdQ4RtfQ7xJ7Fz/7NGNFwYW7iIa83HngxPQOsptTmlclWa4kc+9NT
         Fh1hSd4MsXc+If6/p3HZgtFhEPy+Re4/65kEM=
Received: by 10.213.27.81 with SMTP id h17mr329096ebc.99.1323380654700;
        Thu, 08 Dec 2011 13:44:14 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id z43sm10269169eef.7.2011.12.08.13.44.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 13:44:14 -0800 (PST)
In-Reply-To: <7vpqg1e3au.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186597>

On Tue, 06 Dec 2011 23:35:53 +0100, Junio C Hamano <gitster@pobox.com>  
wrote:

> Frans Klaver <fransklaver@gmail.com> writes:
>
>> +#ifndef WIN32
>> +static int is_in_group(gid_t gid)
>> ...
>> +static int have_read_execute_permissions(const char *path)
>> +{
>> +	struct stat s;
>> +	trace_printf("checking '%s'\n", path);
>> +
>> +	if (stat(path, &s) < 0) {
>> + ...
>> +	/* check world permissions */
>> +	if ((s.st_mode&(S_IXOTH|S_IROTH)) == (S_IXOTH|S_IROTH))
>> +		return 1;
>
> Hmm, do you need to do this with stat(2)?
>
> Wouldn't access(2) with R_OK|X_OK give you exactly what you want without
> this much trouble?

I just had a good look through the man page of access(2), and I think it  
depends. access works for the real uid, which is what I attempted to  
implement in the above check as well. However, do we actually need to use  
the real uid or do we need the set uid (geteuid(2))? Would it be safe to  
assume we don't setuid?


> I also think that your permission check is incorrectly implemented.
>
>     $ cd /var/tmp && date >j && chmod 044 j && ls -l j
>     ----r--r-- 1 junio junio 29 Dec  6 14:32 j
>     $ cat j
>     cat: j: Permission denied
>     $ su pogo
>     Password:
>     $ cat j
>     Tue Dec  6 14:32:23 PST 2011
> That's a world-readable but unreadable-only-to-me file.

Will fix if we can't use access(2) due to what I mentioned above.



>> +				warn("file '%s' exists and permissions "
>> +				"seem OK.\nIf this is a script, see if you "
>> +				"have sufficient privileges to run the "
>> +				"interpreter", sb.buf);
>
> Does "warn()" do the right thing for multi-line strings like this?

Looking back on it, I think I actually wanted to use warning() from  
usage.c. I'll still have to check if that does the multi-line thing as I  
expect it to.
