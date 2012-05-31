From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv2] Possibility to read both from ~/.gitconfig and from
 $XDG_CONFIG_HOME/git/config
Date: Thu, 31 May 2012 23:06:48 +0100
Message-ID: <4FC7EB78.5090903@ramsay1.demon.co.uk>
References: <1338400509-26087-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> <1338412775-22840-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> <7vr4u1xrkp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 00:07:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaDWg-0005JP-GR
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 00:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab2EaWHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 18:07:19 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:44693 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754135Ab2EaWHS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 18:07:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SaDWV-0006x5-fy; Thu, 31 May 2012 22:07:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vr4u1xrkp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198950>

Junio C Hamano wrote:
> Huynh Khoi Nguyen NGUYEN  <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
[...]

>> diff --git a/config.c b/config.c
>> index 71ef171..53557dc 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -939,10 +939,23 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>>  
>>  	home = getenv("HOME");
>>  	if (home) {
>> -		char buf[PATH_MAX];
>> -		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
>> -		if (!access(user_config, R_OK)) {
>> -			ret += git_config_from_file(fn, user_config, data);
>> +		const char *gitconfig_path = xstrdup(mkpath("%s/.gitconfig", home));
>> +		const char *xdg_config_path = NULL;
>> +		const char *xdg_config_home = NULL;
>> +
>> +		xdg_config_home = getenv("XDG_CONFIG_HOME");
>> +		if (xdg_config_home)
>> +			xdg_config_path = xstrdup(mkpath("%s/git/config", xdg_config_home));
>> +		else
>> +			xdg_config_path = xstrdup(mkpath("%s/.config/git/config", home));
> 
> Exactly the same comment applies here, too.

I have not tried this patch (or the v3 version, which I haven't read yet), but
is it likely that this has re-introduced the bug addressed by commit 05bab3ea
("config.c: Fix a static buffer overwrite bug by avoiding mkpath()", 19-11-2011)?.

I don't know the answer, but I suspect that it may have done just that. (indeed, it
may well have made the bug more likely to appear).

> 
> The original that read from $HOME/.gitconfig was simple enough so
> having three copies of getenv("HOME") was perfectly fine, but as you
> are introduce this much complexity to to decide which two files to
> read from, the code added this patch needs to be refactored and
> three copies of the same logic need to be consolidated, I would have
> to say.

I agree. Also, using mksnpath() in the refactored code (rather than
mkpath()) would be a good idea. :-P

ATB,
Ramsay Jones
