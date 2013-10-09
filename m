From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] clone: do not segfault when specifying a nonexistent branch
Date: Wed, 9 Oct 2013 18:38:02 +0200
Message-ID: <CAN0XMOLRt=kJPNhNDSfY_oMV90Xp=_wY=yf0OhiAcaShhWLCnA@mail.gmail.com>
References: <524EC896.3050703@opensoftware.pl>
	<1380896459-6451-1-git-send-email-stefanbeller@googlemail.com>
	<CACsJy8BX_fWdsCGa4jnh4CbkSMxp7btOFjwzB9K0eRtjUR_F-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	robert.mitwicki@opensoftware.pl,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 18:38:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTwm9-0002Nv-Uj
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 18:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab3JIQiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 12:38:06 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:40631 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab3JIQiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 12:38:04 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so1176358wgh.14
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LSkEieCc5IEnEai+YFxFBNeC5AdJqtYjJuganhmZI9w=;
        b=YKHKdzUgWrXjrEwyEdOFPl8+GMEDRxyLfh3mFzOm42lCWbImsu0RNC+Ozh0hKrzdY2
         FuRdlik5DUrSpAKfd5Ze6JuR5cVN+/0cjOXhTy28hhctLxGWJPsGlfeV8b3rJ0/9csRc
         emGclDcPCvTuNFItVtsAfHLxSLmPzuA37uMHRUk1CCyrXcZ2lBPUV3oH6ct6kocv+s9N
         NbA7R14C3Q3qG0a4VoBiy+lR3jGxe/3yqtGyyHHp3QTwEd/gzzTpScWVtrJ4N2Flm9a3
         EIF0GZ0wptYA7FezSe0U6bO0PTBrrCi+ssF5k2ukJiIzG2hx+ECkiddfJ4PlNvX+Ttf3
         Qo6A==
X-Received: by 10.180.10.8 with SMTP id e8mr3468841wib.65.1381336683024; Wed,
 09 Oct 2013 09:38:03 -0700 (PDT)
Received: by 10.194.165.163 with HTTP; Wed, 9 Oct 2013 09:38:02 -0700 (PDT)
In-Reply-To: <CACsJy8BX_fWdsCGa4jnh4CbkSMxp7btOFjwzB9K0eRtjUR_F-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235829>

On Sat, Oct 5, 2013 at 1:55 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Oct 4, 2013 at 9:20 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>> I think we should emit a warning additionally?
>>
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>
> I think it's nice to credit Robert for reporting the fault in the
> commit message (something like "reported-by:" or "noticed-by:"...)
>
>> ---
>>  builtin/clone.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 0aff974..b764ad0 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -688,7 +688,7 @@ static void write_refspec_config(const char* src_ref_prefix,
>>
>>         if (option_mirror || !option_bare) {
>>                 if (option_single_branch && !option_mirror) {
>> -                       if (option_branch) {
>> +                       if (option_branch && our_head_points_at) {
>>                                 if (strstr(our_head_points_at->name, "refs/tags/"))
>>                                         strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
>>                                                 our_head_points_at->name);
>
> This prevents the segfault, but what about remote.*.fetch? Should we
> setup standard refspec for fetch or..?
> --
> Duy

This segfault only happens when cloning an empty repository and only with option
"--single-branch". Or do I miss something?

If we call "git clone" for a non-empty repository with a non-existing branch
using "[--single-branch] --branch foo" then Git will abort with a message that
the branch doesn't exist in upstream.

In an empty upstream repo the branch doesn't exist, either. So why not
abort with
the same message? That would be consistent. Otherwise I'd just
override the options
"--single-branch" and "--branch" to "not set".

Ralf
