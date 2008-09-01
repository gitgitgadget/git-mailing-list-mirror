From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Tue, 2 Sep 2008 01:52:48 +0300
Message-ID: <94a0d4530809011552h59e476e0q9033f0b917288a8f@mail.gmail.com>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
	 <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
	 <20080901223802.GK7482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 00:53:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIHT-00055i-8f
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 00:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbYIAWwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 18:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYIAWwt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 18:52:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:5268 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYIAWws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 18:52:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1988528rvb.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=95XE0gm0aymSX/XM30A0bsggly+DQBpGwQOCIYHX3kI=;
        b=j013D+DU0qjv8Qmw0rTRmE+9IE84Izk6NY/PjWRA0RVcM0CA53wQw2L5KR6k0rQoyQ
         jtznN81BCxlS7k0OAMwO50e1+fNQLcVGoqLLNaOoTccdfAQL5z4ZFwGHg3SfG8wFcQ+3
         Vg9Tyg36rjJUqNhjY8Vmkk+JNV8ThdPllP0bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WsZXxz5qNrB186EplIei9EjhXPXAiwmkp2XvkTj4OChBEwPsuhDAY6UEOp4EkR3Iw4
         iGRSNE7uBPE01h8cAtNZGNf7oACXD+/hehevZnHgU3wt/fmlsFrbx+Lym8RjnekDHOrD
         L0QlqL5MU7+Vg8l7nFBw365n8pEriMBFLP0Ms=
Received: by 10.141.162.6 with SMTP id p6mr3742463rvo.121.1220309568199;
        Mon, 01 Sep 2008 15:52:48 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Mon, 1 Sep 2008 15:52:48 -0700 (PDT)
In-Reply-To: <20080901223802.GK7482@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94621>

On Tue, Sep 2, 2008 at 1:38 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> This is useful for SCMs that don't have proper changesets in each
>> revision (monotone).
>
>> +--tolerant::
>> +     Avoid fatal exceptions when actions are executed in non-existent
>> +     files.  For example removing a file that is not there.
>> +
>
> Yea.  But I'm not sure --tolerant is the best name.  --ignore-errors
> or --treat-errors-as-warnings sounds better to me.

I initially named it --ignore-non-existent, but I thought the option
was too specific.

--ignore-errors or --treat-errors-as-warnings imply all errors. It
might make sense to always fail at certain errors, like 'mark not
found'. I thought 'relaxed' or 'tolerant' would imply that only some
errors will be allowed, not all.

>> diff --git a/fast-import.c b/fast-import.c
>> index 7089e6f..01be3fa 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -345,6 +345,7 @@ static struct recent_command *rc_free;
>>  static unsigned int cmd_save = 100;
>>  static uintmax_t next_mark;
>>  static struct strbuf new_data = STRBUF_INIT;
>> +static int tolerant;
>>
>>  static void write_branch_report(FILE *rpt, struct branch *b)
>>  {
>> @@ -1993,8 +1994,15 @@ static void file_change_cr(struct branch *b, int rename)
>>               tree_content_remove(&b->branch_tree, s, &leaf);
>>       else
>>               tree_content_get(&b->branch_tree, s, &leaf);
>> -     if (!leaf.versions[1].mode)
>> -             die("Path %s not in branch", s);
>> +     if (!leaf.versions[1].mode) {
>> +             if (tolerant) {
>> +                     if (leaf.tree)
>> +                             release_tree_content_recursive(leaf.tree);
>> +                     warning("Path %s not in branch", s);
>> +                     return;
>> +             } else
>> +                     die("Path %s not in branch", s);
>> +     }
>>       tree_content_set(&b->branch_tree, d,
>>               leaf.versions[1].sha1,
>>               leaf.versions[1].mode,
>> @@ -2447,6 +2455,8 @@ int main(int argc, const char **argv)
>>                       show_stats = 0;
>>               else if (!strcmp(a, "--stats"))
>>                       show_stats = 1;
>> +             else if (!strcmp(a, "--tolerant"))
>> +                     tolerant = 1;
>>               else
>>                       die("unknown option %s", a);
>>       }
>
> --
> Shawn.
>



-- 
Felipe Contreras
