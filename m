From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Sat, 6 Sep 2014 09:31:06 +1200
Message-ID: <CAFOYHZBct1CRA+NumVMvbbuELWTRoGL5FkhBfHD2Wk7QZVe1fA@mail.gmail.com>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
	<1409911611-20370-2-git-send-email-judge.packham@gmail.com>
	<540A1C7B.80109@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, Stephen Boyd <bebarino@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 23:31:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ169-0004Qt-Gd
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 23:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbaIEVbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 17:31:08 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:62052 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaIEVbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 17:31:07 -0400
Received: by mail-pa0-f43.google.com with SMTP id et14so23030797pad.16
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5dbeUAwek9WXtw/0EvoaySnXumGpQS+2/vUycE/tS2I=;
        b=lQZQ9Ih8vWlKGc6bo4Ln7YUvilzdWXX5I5wwBSsb5vPsy56ACPpV86KC/skXImihDo
         WbTeCWrfLVoLIsHiY1P+33Qh2q8j1yZbR4Xb4qjw6aNd/Po3P3v52TtSCpiRM/NAgs2m
         GJCsfD6EsJymj3iCtOxIBw5FxtbPYDYobq5eYWCQMDNDu3bDQFWntcmTK3EAll4dtken
         eO+Xyx8if3i4zgyt3wbve4vztwYmCqIcAjMgPnsCoNpn9jjFDj+1OQx7Iq76tytZ8xua
         KtmwHIsS3PurZZNfMfeaoB862rjUUmtC6X+t8KUAtPgdMG54Ay4GcG9Fap0tsBpai7O4
         oMoA==
X-Received: by 10.66.178.205 with SMTP id da13mr23433176pac.146.1409952666525;
 Fri, 05 Sep 2014 14:31:06 -0700 (PDT)
Received: by 10.70.36.6 with HTTP; Fri, 5 Sep 2014 14:31:06 -0700 (PDT)
In-Reply-To: <540A1C7B.80109@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256542>

On Sat, Sep 6, 2014 at 8:26 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 05.09.2014 12:06, schrieb Chris Packham:
>> In check_patch_format we feed $1 to a block that attempts to determine
>> the patch format. Since we've already redirected $1 to stdin there is no
>> need to redirect it again when we invoke tr. This prevents the following
>> errors when invoking git am
>>
>>   $ git am patch.patch
>>   tr: write error: Broken pipe
>>   tr: write error
>>   Patch format detection failed.
>>
>> Cc: Stephen Boyd <bebarino@gmail.com>
>> Signed-off-by: Chris Packham <judge.packham@gmail.com>
>> ---
>> Nothing new since http://article.gmane.org/gmane.comp.version-control.git/256425
>>
>>  git-am.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-am.sh b/git-am.sh
>> index ee61a77..fade7f8 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
>> @@ -250,7 +250,7 @@ check_patch_format () {
>>                       # discarding the indented remainder of folded lines,
>>                       # and see if it looks like that they all begin with the
>>                       # header field names...
>> -                     tr -d '\015' <"$1" |
>> +                     tr -d '\015' |
>>                       sed -n -e '/^$/q' -e '/^[       ]/d' -e p |
>>                       sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
>>                       patch_format=mbox
>>
>
> I think this change is wrong. This pipeline checks whether one of the
> lines at the top of the file contains something that looks like an email
> header. With your change, the first three lines would not be looked at
> because they were already consumed earlier.
>
> I wonder why tr (assuming it is *this* instance of tr) dies with a write
> error instead of from a SIGPIPE. Is SIGPIPE ignored somewhere and then
> the tr invocation inherits this "ignore SIGPIPE" setting?
>
> The only thing your version changes is that tr writes a bit less text
> into the pipe. Perhaps its just sufficient that the output fits into the
> pipe buffer, and no error occurs anymore? Then the new version is not a
> real fix: make the patch text a bit longer, and the error is back.
>
> -- Hannes
>

I did notice some oddities when attempting to reproduce this issue.
They would be explained by the output fitting into the buffer. So yes
perhaps this solution has just changed enough so that it no longer
triggers on the particular patch I was testing with. It still seems a
bit funny that we start re-reading the input part way through
processing it.

Perhaps putting the tr outside the whole block would be a better solution?
