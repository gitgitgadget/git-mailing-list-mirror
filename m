From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC/PATCH] notes.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 13:50:28 +0530
Message-ID: <53ABD7CC.105@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-5-git-send-email-tanayabh@gmail.com> <CAPig+cR-fdXCe+9e89++KrLPqfPkbSi4FeU_gD=fwfrMnH-a2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:20:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X04v7-0007jG-4k
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 10:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbaFZIUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 04:20:33 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44174 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbaFZIUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 04:20:32 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so2751621pdi.13
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=U6+W6c3ZUtuqahZoumxdYZsM3QDzwIqkhQJru2W6bms=;
        b=qs5XvHMCBqMtdQnoTye6fQtzyQuKjHWSkAMIQ/cFsOfA5GAvo/9sd4VWU7bUaeWGYp
         exIu4bFpDjQQnqtWY3VOP1L0gsR5OhE2m+xuf09PJgDIps2v4Z6da4JUOglalGdv4OAR
         HHN6h5W/eTEw2qZDXjSV4sbDBkAhxGY+k1phenJGnLtb1iunpy4gzzvw6ajytCOujnTN
         rSsWBS/bfsV8flpsVRnaHyg8J/Dwg0lS3wnxFEhZVt1NrRCBAdyiyGDFVez34+WQLCTX
         RUb9KNN/4YCeTdc9o5kWl2hBgMZQ9zw93fpnOnMgCP3/SPs2V40x2HoQxdCqMm4+ZSaL
         8dxw==
X-Received: by 10.68.252.73 with SMTP id zq9mr19601440pbc.146.1403770831349;
        Thu, 26 Jun 2014 01:20:31 -0700 (PDT)
Received: from [127.0.0.1] ([117.251.76.15])
        by mx.google.com with ESMTPSA id sv10sm31139228pab.32.2014.06.26.01.20.28
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 01:20:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cR-fdXCe+9e89++KrLPqfPkbSi4FeU_gD=fwfrMnH-a2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252491>



On 6/25/2014 1:36 PM, Eric Sunshine wrote:
> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>> Use git_config_get_string instead of git_config to take advantage of
>> the config hash-table api which provides a cleaner control flow.
>>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  notes.c | 20 ++++++--------------
>>  1 file changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/notes.c b/notes.c
>> index 5fe691d..fc92eec 100644
>> --- a/notes.c
>> +++ b/notes.c
>> @@ -961,19 +961,6 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
>>         free(globs_copy);
>>  }
>>
>> -static int notes_display_config(const char *k, const char *v, void *cb)
>> -{
>> -       int *load_refs = cb;
>> -
>> -       if (*load_refs && !strcmp(k, "notes.displayref")) {
>> -               if (!v)
>> -                       config_error_nonbool(k);
>> -               string_list_add_refs_by_glob(&display_notes_refs, v);
>> -       }
>> -
>> -       return 0;
>> -}
>> -
>>  const char *default_notes_ref(void)
>>  {
>>         const char *notes_ref = NULL;
>> @@ -1041,6 +1028,7 @@ struct notes_tree **load_notes_trees(struct string_list *refs)
>>  void init_display_notes(struct display_notes_opt *opt)
>>  {
>>         char *display_ref_env;
>> +       const char *value;
>>         int load_config_refs = 0;
>>         display_notes_refs.strdup_strings = 1;
>>
>> @@ -1058,7 +1046,11 @@ void init_display_notes(struct display_notes_opt *opt)
>>                         load_config_refs = 1;
>>         }
>>
>> -       git_config(notes_display_config, &load_config_refs);
>> +       if (load_config_refs && !git_config_get_string("notes.displayref", &value)) {
>> +               if (!value)
>> +                       config_error_nonbool("notes.displayref");
>> +               string_list_add_refs_by_glob(&display_notes_refs, value);
> 
> Although you correctly diagnose a NULL 'value', you then invoke
> string_list_add_refs_by_glob() with that NULL, which will result in a
> crash.
> 
> This is not a new error. It dates back to 894a9d33 (Support showing
> notes from more than one notes tree; 2010-03-12), but your rewrite
> should not retain the brokenness. Whether you fix it in this patch or
> a lead-in fix-up patch, the fix deserves mention in the commit
> message.

Done. Thanks.

>> +       }
>>
>>         if (opt) {
>>                 struct string_list_item *item;
>> --
>> 1.9.0.GIT
> 
