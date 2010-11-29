From: Jeremy Huddleston <jeremyhu@apple.com>
Subject: Re: [PATCH updated] Fallback on _NSGetExecutablePath to get the executable path if using argv[0] fails
Date: Mon, 29 Nov 2010 16:02:00 -0500
Message-ID: <5873960D-848E-4039-B884-AA5B4E1787B8@apple.com>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com> <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com> <20101129171211.GL8037@burratino> <DD9829B7-8851-41CF-BCC6-2676B6015028@apple.com> <20101129184929.GA9441@burratino> <7veia32803.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 22:02:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNArX-0002N1-UN
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 22:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab0K2VCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 16:02:10 -0500
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:45217 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab0K2VCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 16:02:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.outersquare.org (Postfix) with ESMTP id 6A8F153FC9;
	Mon, 29 Nov 2010 13:02:08 -0800 (PST)
X-Virus-Scanned: amavisd-new at mail.outersquare.org
Received: from mail.outersquare.org ([127.0.0.1])
	by localhost (mail.outersquare.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gsn5jV5S-djC; Mon, 29 Nov 2010 13:02:03 -0800 (PST)
Received: from [192.168.1.100] (c-71-235-225-119.hsd1.ct.comcast.net [71.235.225.119])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jeremy@mail.outersquare.org)
	by mail.outersquare.org (Postfix) with ESMTPSA id 32C9C53CE1;
	Mon, 29 Nov 2010 13:02:02 -0800 (PST)
In-Reply-To: <7veia32803.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162429>


On Nov 29, 2010, at 15:24, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>>> --- a/exec_cmd.c
>>> +++ b/exec_cmd.c
>> [...]
>>> @@ -53,6 +57,19 @@ const char *git_extract_argv0_path(const char *argv0)
>>> 	if (slash >= argv0) {
>>> 		argv0_path = xstrndup(argv0, slash - argv0);
>>> 		return slash + 1;
>>> +#if defined(__APPLE__)
>>> +	} else {
>>> +		char new_argv0[PATH_MAX];
>>> +		uint32_t new_argv0_s = PATH_MAX;
>>> +		if(_NSGetExecutablePath(new_argv0, &new_argv0_s) == 0) {
>>> +			slash = new_argv0 + strlen(new_argv0);
>>> +			while (new_argv0 <= slash && !is_dir_sep(*slash))
>>> +		                slash--;
>>> +
>>> +			if (slash >= new_argv0)
>>> +				argv0_path = xstrndup(new_argv0, slash - new_argv0);
>>> +		}
>>> +#endif
>> 
>> Can't this ifdef be avoided?  The ideal is for such code to be
>> abstracted away into helper functions in git-compat-util.h and compat/*.c.
> 
> I had exactly the same reaction.  Also doesn't the above need to be
> protected by defined(RUNTIME_PREFIX), too?

It already is inside of an #ifdef RUNTIME_PREFIX block.
