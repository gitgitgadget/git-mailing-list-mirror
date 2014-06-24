From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Tue, 24 Jun 2014 17:36:53 +0530
Message-ID: <53A969DD.2030201@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com> <vpqtx7bn8ln.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:07:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzPVG-0007zX-4s
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 14:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbaFXMHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 08:07:04 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:38090 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbaFXMHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 08:07:02 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so178992pbc.2
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 05:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=sU3Np0Fj+fzQTubr+Y9ntrN5T36QEOue0OZCJIVcIZA=;
        b=kOHzCE1YR56vDHAIvDqJy2ONXVx4g02ahkwOrTfJ6a1qcfsKeW9ScNhvW8s/QBbp30
         U4rX5dHttHB/AITVJdhygRxznh9SxOBWXjQdO4qiOIL5gKPObV9MkAr5vFPIpfmfVPgq
         LKqk+MzVz6uMLvAkq9WUf60XD6m68CSEZQO6Qvu5bre//cjJsUX+FtxCu3Y1kjJFLAf2
         79y1NxMRPCu/Zz1aYfgcpW0UkCbMD/nUTODzXWlCI00q6meBTGSkjWXFj/CMFBL9Zffj
         B8C/L94QgIqtv4mXWoNKNbZcLncDg1Nd8oUBXKMhNEQI22LS5EvnlnwuKeT/ps/0sW7q
         0S3g==
X-Received: by 10.66.149.102 with SMTP id tz6mr890439pab.76.1403611621665;
        Tue, 24 Jun 2014 05:07:01 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.217.87])
        by mx.google.com with ESMTPSA id fn2sm440410pab.22.2014.06.24.05.06.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 05:07:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <vpqtx7bn8ln.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252403>

On 6/23/2014 5:25 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> +/* for NULL values, 'util' for each `string_list_item` is flagged as 1 */
>
> It's a void *, so just saying that it is flagged as 1 does not say how
> it's encoded. How about "... is an 'int *' pointing to the value 1".
>
> And actually, you can save one malloc by encoding the value directly in
> the util pointer itself like
>
> #define NULL_FLAG (void *)1
>
> 	item->util = NULL_FLAG;
>
> I find this a bit ugly, but I think Git already uses this in a few
> places (git grep 'void \*) *1' for examples).
>
> Or you can use a pointer to a single static value:
>
> static const int boolean_null_flag = 1; // Or even without = 1.
>
> and then
>
> 	item->util = &boolean_null_flag;
>

Thanks for the review. I will change the flag format to what you have
suggested. Instead of giving the users of the API the headache of
thinking about the flag, let me give you an alternative,

+const struct string_list *git_config_get_string_multi(const char *key)
+{
+	int i, *flag;
+	struct string_list *temp = config_cache_get_value(key);
+	if (!temp)
+		return NULL;
+	/* create a NODUP string list which can have NULL values */
+	struct string_list *l = xcalloc(1, sizeof(*l));
+	for(i=0; i < temp->nr; i++) {
+		flag = temp->items[i].util;
+		if (*flag)
+			string_list_append(l, NULL);
+		else
+			string_list_append(l, temp->items[i].string);
+	}
+	return l;
+}

Now the only headache for the user will be to free the string-list once
he is done with it. What do you think about this approach?

Also I have a doubt, when rewriting git_config() callers I saw a
curious case, when at the end of the callback they sometimes call
git_default_config().

For example in add.c,

static int add_config(const char *var, const char *value, void *cb)
{
	if (!strcmp(var, "add.ignoreerrors") ||
	    !strcmp(var, "add.ignore-errors")) {
		ignore_add_errors = git_config_bool(var, value);
		return 0;
	}
	return git_default_config(var, value, cb);
}

What should I do about this, should I change the default_config() calls
to git_config_get_string calls which I can easily do, if the values it 
is setting are not being set by any other callers.

For example in config.c,

static int git_default_core_config(const char *var, const char *value)
{
	/* This needs a better name */
	if (!strcmp(var, "core.filemode")) {
		trust_executable_bit = git_config_bool(var, value);
		return 0;
	}
	if (!strcmp(var, "core.trustctime")) {
		trust_ctime = git_config_bool(var, value);
		return 0;
	}
	if (!strcmp(var, "core.statinfo") ||
	    !strcmp(var, "core.checkstat")) {
--[snip]
variables like "core.filemode" or "core.statinfo" have been requested 
here only in the whole codebase, so I am safe to rewrite this function
with git_config_get_string, am I?

If not many callers (add_config...) behave like this. What should I
do with them?

Also, what are your views for the points Ramsay has raised.

Cheers,
Tanay Abhra.
