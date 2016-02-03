From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 6/8] git submodule update: have a dedicated helper for cloning
Date: Wed, 3 Feb 2016 15:41:36 -0800
Message-ID: <CAGZ79kbeDBf=AfA2RUhkfjwJqJ7pr30xW3UTXqiha_EPpisvnw@mail.gmail.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-7-git-send-email-sbeller@google.com>
	<xmqqr3gtjs23.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:41:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR73R-0007dq-NA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350AbcBCXli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:41:38 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33239 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933313AbcBCXlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:41:36 -0500
Received: by mail-ig0-f172.google.com with SMTP id rs20so2017431igc.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 15:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mi0L2PzmzN32CDO83t/TzIkNYvU3YPhEzs4TGz3g/R0=;
        b=YW+frXvVUpQfA9RUY+QkQJNceLtjN6IajDKcaAjeoo+z18AKSrFdoeTqFIiWHHbx8U
         KfXpeUn+BdcNR6Z10fe4i+pqcdfeBTmsnmcA7+mIipzfJrW+q21xAVTGWx5DRPgXKTys
         1F291d+HSTKS86anLPFxh4pdK2ZBzucizpB8V7BiqwX/pLMP6SF3Yu1FeMiSrHQOF8Ym
         VgsfpBgpKrXNZolACGwr89PHuYJ07joZvhugtQ0JYBnVvGiu34PJr8mpgC8Cw8yblPt4
         KBKdDpQH6UwirSGfuwltoyqGQzRWT1eG+TjZzkWDi7rLbK8xvnXOcC23i8yvtfuIkian
         yzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mi0L2PzmzN32CDO83t/TzIkNYvU3YPhEzs4TGz3g/R0=;
        b=Tbgo5PDxSxs4spl7LBm/Q1LzgIUWr5W6Hf8czKK9Ev5DRgdKVC9vmxm75MrWlmD6UZ
         JTf9/QtU4JELJ4AsQBcYUuYFwq3Lfo3SejFNpb8g28iE9v9/eop0azmzcjVRkIE5CvDP
         pmUFax2FjVLMTLopuZa1FZx+C0PIRnT6cNNExZLa1AkOaW/xKwjQYoos3Y7HJBsNmeNk
         vwxk5x4mSl85Prbu7hjdMWDbpy/ikDlQAUqlcDO+FM33EkNsEB/vmcPUizgZvASe3T+B
         7/vHoQb+Sk3VwHOv60uDzcO1ZWa0W+VOCDqe423mCMBsbvlUypzeDIvZpcGIsA56sNRY
         SnRA==
X-Gm-Message-State: AG10YOSsfZynnmJEjP8/OC7Kf9xYT7STdHeQaB2ic7w3lOXDxrYmw3qNWOYRx/u3GAw1ZdtlQwOQWh3m9xLUno53
X-Received: by 10.50.61.197 with SMTP id s5mr3785670igr.94.1454542896085; Wed,
 03 Feb 2016 15:41:36 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 3 Feb 2016 15:41:36 -0800 (PST)
In-Reply-To: <xmqqr3gtjs23.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285384>

On Wed, Feb 3, 2016 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +             if (ce_stage(ce)) {
>> +                     if (pp->recursive_prefix)
>> +                             strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
>> +                                     pp->recursive_prefix, ce->name);

As a side question: Do we care about proper visual directory
separators in Windows?

>> +                     else
>> +                             strbuf_addf(err, "Skipping unmerged submodule %s\n",
>> +                                     ce->name);
>> +                     continue;
>
> This raised my eyebrow somewhat, until I realized that it is OK
> because module_list prepared by the caller has only one of the
> unmerged entries for the same path to avoid duplicates.
>
>> +             }
>> +
>> +             sub = submodule_from_path(null_sha1, ce->name);
>> +             if (!sub) {
>> +                     strbuf_addf(err, "BUG: internal error managing submodules. "
>> +                                 "The cache could not locate '%s'", ce->name);
>> +                     pp->print_unmatched = 1;
>> +                     continue;
>
> Interesting.
>
> I am wondering if this check should go to module_list_compute().

Actually this has evolved from a debugging leftover camouflaged as a
useful thing.
I added that and then realized I did not add

        gitmodules_config();
        git_config(git_submodule_config, NULL);

before, but that code remained there as it seemed useful to me at the time.

I never run into this BUG after having proper initialization, so maybe it's not
worth carrying this code around. (We have many other places where
submodule_from_{path, name} is used unchecked, so why would this place
be special?)

>
>> +             }
>> +
>> +             if (pp->recursive_prefix)
>> +                     displaypath = relative_path(pp->recursive_prefix, ce->name, &sb);
>> +             else
>> +                     displaypath = ce->name;
>> +
>> +             if (pp->update)
>> +                     update_module = pp->update;
>> +             if (!update_module)
>> +                     update_module = sub->update;
>> +             if (!update_module)
>> +                     update_module = "checkout";
>> +             if (!strcmp(update_module, "none")) {
>> +                     strbuf_addf(err, "Skipping submodule '%s'\n", displaypath);
>> +                     continue;
>> +             }
>> +
>> +             /*
>> +              * Looking up the url in .git/config.
>> +              * We must not fall back to .gitmodules as we only want to process
>> +              * configured submodules.
>> +              */
>> +             strbuf_reset(&sb);
>
> Doesn't this invalidate displaypath, when pp->recursive_prefix is in
> effect?  It still seems to be used to create an error message just a
> few lines below...

Yes that is programmer error. Also the final cleanup of the strbuf is missing.

>
>> +             strbuf_addf(&sb, "submodule.%s.url", sub->name);
>> +             git_config_get_string(sb.buf, &url);
>> +             if (!url) {
>> +                     /*
>> +                      * Only mention uninitialized submodules when its
>> +                      * path have been specified
>> +                      */
>> +                     if (pp->pathspec.nr)
>> +                             strbuf_addf(err, _("Submodule path '%s' not initialized\n"
>> +                                     "Maybe you want to use 'update --init'?"), displaypath);
>> +                     continue;
>> +             }
