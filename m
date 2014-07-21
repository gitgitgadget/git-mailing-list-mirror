From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 0/6] git_config callers rewritten with the new config
 cache API
Date: Mon, 21 Jul 2014 18:45:44 +0530
Message-ID: <53CD1280.1080107@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com> <vpqegxeeuyb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 21 15:15:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9DRa-0005yo-I7
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 15:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbaGUNPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 09:15:50 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:61236 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbaGUNPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 09:15:49 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so9141090pdj.36
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tenwMoBiK5Zy8cdfbm/5oVPyDihUCcFiTA1y7XDahC0=;
        b=tDnPc1gOh/x5+c2SiOi1lBdzxsop746Nf0mpbtVbpP7pjduNqMmLSC0sX/wKY0Vyyi
         txpNdaTRcpLHSS06PSC0s+WstASu5nIstLiK5lmXI8WeV8oqikyS+W2jVk358TikXFm7
         PfC+p1j6TfLOaptHqyK7kWrFscOe6+whBq3P4zc+Or3Gb+axQ6UVj+/t2VPaUFUKza2H
         rjiOI3xF9yF05oBrLiH/cv6LHKzZ4le1TZvjD8s136yjic9NkERU/IM2x6B6R/GAH2v4
         UYKTHmHJtM0vSVnHaeT35PEg/2mGIkw9iL/qTuQm/O7qtXLwwWHkw8KFUxwzApvNawDP
         rarw==
X-Received: by 10.69.17.230 with SMTP id gh6mr25187604pbd.0.1405948549380;
        Mon, 21 Jul 2014 06:15:49 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.246.202])
        by mx.google.com with ESMTPSA id ba10sm19113404pdb.73.2014.07.21.06.15.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 06:15:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqegxeeuyb.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253960>



On 7/21/2014 6:21 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> [PATCH v3]: Most of Eric's suggestions has been implemented. See [2] for discussion.
>> 	Also, new helpers introduced in v7 of the config-set API series have been used.
>> 	See [1] for the documentation of the new functions.
>>
>> This series builds on the top of 5def4132 in pu or topic[1] in the mailing list
>> with name "git config cache & special querying API utilizing the cache".
> 
> It's now called ta/config-set (see last "What's cooking in git.git").
>

Noted. More below.

>> All patches pass every test, but there is a catch, there is slight behaviour
>> change in most of them where originally the callback returns
>> config_error_nonbool() when it sees a NULL value for a key causing a die
>> specified in git_parse_source in config.c.
>>
>> The die also prints the file name and the line number as,
>>
>> 	"die("bad config file line %d in %s", cf->linenr, cf->name);"
>>
>> We lose the fine grained error checking when switching to this method.
> 
> I think a first step would be something like this:
> 
> --- a/config.c
> +++ b/config.c
> @@ -656,6 +656,15 @@ int git_config_string(const char **dest, const char *var, const char *value)
>         return 0;
>  }
>  
> +// TODO: either make it static or export it properly
> +int git_config_string_or_die(const char **dest, const char *var, const char *value)
> +{
> +       if (git_config_string(dest, var, value) < 0)
> +               die("bad config file (TODO: file/line info)");
> +       else
> +               return 0;
> +}
> +
>  int git_config_pathname(const char **dest, const char *var, const char *value)
>  {
>         if (!value)
> @@ -1336,7 +1345,7 @@ int git_configset_get_string(struct config_set *cs, const char *key, const char
>  {
>         const char *value;
>         if (!git_configset_get_value(cs, key, &value))
> -               return git_config_string(dest, key, value);
> +               return git_config_string_or_die(dest, key, value);
>         else
>                 return 1;
>  }
> 
> In the original API, git_config_string was called at parsing time, hence
> the file/line information was available through "cf". Here, we're
> querying the cache which doesn't have this information yet.
> 
> I initially thought that managing properly file/line information would
> be just an addition, but this example shows that it is actually needed
> to be feature-complete wrt the old API. And I think we should be
> feature-complete (i.e. make the code cleaner without harming the user).
> 
> So, I think it now makes sense to resurect your "file line info" patch:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/253123
> 
> Now that the series is properly reviewed, avoid modifying existing
> patches as much as possible, and add these file/line info on top of the
> existing.
> 
> I think you need to:
> 
> 1) Modify the hashmap data structure and the code that fills it in to
>    store the file/line info (already done in your previous WIP patch).
> 
> 2) Add a by-address parameter to git_configset_get_value that allows the
>    user to get the file and line information. In your previous patch,
>    that would mean returning a pointer to the corresponding struct
>    key_source.

Will this extra complexity be good for "git_configset_get_value"?
Instead can we provide a function like die_config(char *key)
which prints
	die("bad config file line %d in %s", linenr, filename);?
A variation would be die_config_multi(char *key, char *value)
for multi valued keys.

> 3) Pass this information to git_config_string_or_die, and die with the
>    right message (with a helper like die_config(struct key_source *ks)
>    that takes care of the formatting)

No need for passing if we use the above method. We will just call die_config()
inside it for NULL values

> 4) apply the same to git_config_get_<other than string>.
>
> I'd actually add a step 0) before that: add a test that checks your
> behavior change. The test should pass without your patches, and fail
> with your current patch. Then, it should pass again once you completed
> the work.
>

Noted, I will add it.

> On a side note, re-reading your previous patch, I found this which
> sounds suspicious:
> 
> +	struct config_hash_entry *e;
> +	struct string_list_item *si;
> +	struct key_source *ks = xmalloc(sizeof(*e));
> 
> Didn't you mean xmalloc(sizeof(*ks))?
>

Yikes, Thanks.
