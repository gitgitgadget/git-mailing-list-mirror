From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Sun, 10 Oct 2010 15:50:39 -0400
Message-ID: <4CB2190F.6000908@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 21:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P51v1-0004v3-Ey
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab0JJTuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 15:50:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45594 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0JJTup (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 15:50:45 -0400
Received: by pzk34 with SMTP id 34so842829pzk.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=bVHuABbfW4XsmN6i2XcDCO1CDFKWhpD5RTk34Wf04Lo=;
        b=I6R2rVN2Sy7oLZ5G+cMqkfpm0h0S81vfvN480CaMc+nCHEeV2Bw0SYHoIx2AMRg/jx
         tt/e7wClw6NoJ17Qf+Iv5vXmirOuiL7Al9vu/PHPmAN/8ai9Y5KFau/A2mjyUQGfSAEm
         PlstfMzZcu2UQ1IIM3l13hWi1uxmQU0FI65IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=jiZwJ4nCbrtsxV7HNEd3zq6RazACj4aOewG1mbsJg7hEZQ9apT8WOPAFei+yXOds5l
         5oH9j+ls4dQakMK+RS4bz5dbt/HmEattjkPA9jV1FieStmmh0nPsiHh9YnofGg0xzI4P
         7CPMceJE9gfK8Ec4XYGHbo7ypyc8d3pXwJsW0=
Received: by 10.114.77.13 with SMTP id z13mr6066262waa.45.1286740245080;
        Sun, 10 Oct 2010 12:50:45 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id q29sm8880320waj.6.2010.10.10.12.50.42
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 12:50:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <1286716854-5744-3-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158692>

On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
> From: Mike Pape<dotzenlabs@gmail.com>
>
> Syslog does not usually exist on Windows, so we implement our own
> using Window's ReportEvent mechanism.
>
> Signed-off-by: Mike Pape<dotzenlabs@gmail.com>
> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
> ---
> +void syslog(int priority, const char *fmt, const char *arg)
> +{
> +	WORD logtype;
> +
> +	if (!ms_eventlog)
> +		return;
> +
> +	if (strcmp(fmt, "%s")) {
> +		warning("format string of syslog() not implemented");
> +		return;
> +	}

It is not exactly clear what the intention is here. Is this trying to 
say that no formatting directives are allowed in 'fmt' or what? The 
simple case it is actually checking (where 'fmt' is solely '%s') could 
easily be handled manually, as could more complex formats.

> +	/*
> +	 * ReportEvent() doesn't handle strings containing %n, where n is
> +	 * an integer. Such events must be reformatted by the caller.
> +	 */
> +	ReportEventA(ms_eventlog,
> +	    logtype,
> +	    0,
> +	    0,
> +	    NULL,
> +	    1,
> +	    0,
> +	    (const char **)&arg,
> +	    NULL);

The comment about '%n' seems to be warning about a potential problem but 
does not actually protect against it. Should this issue be handled?

-- ES
