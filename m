From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix problem causing erroneous project list
Date: Fri, 7 Jun 2013 22:39:45 +0200
Message-ID: <CANQwDwfiuNSk+woFheqfi527rfutZ2YYH1h3tjuWh0ziwmU+uQ@mail.gmail.com>
References: <20130605043524.GA2453@compy.Home> <7vd2s01i6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles McGarvey <chazmcgarvey@brokenzipper.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3SI-0003D3-UU
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab3FGUkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:40:08 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:36641 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab3FGUkH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:40:07 -0400
Received: by mail-qa0-f43.google.com with SMTP id d13so1317846qak.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2O5N/XBn8yRG8vsgCc7IO9gPKsasjFvoMTjJS6S/Fk0=;
        b=dvPj3WgcVp6cxU8Cjm0TevXS88iPuVJgSgU4GPM0WBlvgmd39j9cJJss15GuVD0HYc
         FYUSzNlBcRKul3TC/yBjJJlFFKgwgU0DEojrPtoNGZbPwUDTDfKJxLw8BsOi7U33gZkL
         TXETGl1w9FmdmYsUcvGXNiPz9nkB2H/nVDPSwqzcxdp91RnTXfQ9CKKh+aZ4imAL6o07
         pMJeUo4P1DozABeI5zOo2y1N4Ol1OaxIQywzQfFy97f+xpQRf04rmDBfUf7QDZB9dTC7
         4tQS+FHfEDm547Y3ji7uZLjvDkEEW0WdX70jRQ+G4iNJfWQ6QDxOJJCth+jRlziXhkiG
         9NGg==
X-Received: by 10.224.189.194 with SMTP id df2mr4809699qab.97.1370637605677;
 Fri, 07 Jun 2013 13:40:05 -0700 (PDT)
Received: by 10.49.85.41 with HTTP; Fri, 7 Jun 2013 13:39:45 -0700 (PDT)
In-Reply-To: <7vd2s01i6f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226704>

On Wed, Jun 5, 2013 at 9:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Charles McGarvey <chazmcgarvey@brokenzipper.com> writes:
>
>> The bug is manifest when running gitweb in a persistent process (e.g.
>> FastCGI, PSGI), and it's easy to reproduce.  If a gitweb request
>> includes the searchtext parameter (i.e. s), subsequent requests using
>> the project_list action--which is the default action--and without
>> a searchtext parameter will be filtered by the searchtext value of the
>> first request.  This is because the value of the $search_regexp global
>> (the value of which is based on the searchtext parameter) is currently
>> being persisted between requests.
>>
>> Instead, clear $search_regexp before dispatching each request.
>>
>> Signed-off-by: Charles McGarvey <chazmcgarvey@brokenzipper.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

>> ---
>> I don't think there are currently any persistent-process gitweb tests to
>> copy from, so writing a test for this seems to be non-trivial.

Well, there is Plack::Test, and gitweb supports running as PSGI app.
Though all such test would have to be under new PLACK or PSGI
prerequisite.

> The problem description makes sense to me, and clearing with "undef"
> is in line with the case where the CGI is run for the first time, so
> I think this patch is correct.
>
> Will wait for a while to give Jakub some time to comment on (like:
> Ack ;-) and then apply.  Thanks.
>
> By the way, I looked at how $search_regexp is used in the code:

How $search_regexp is used does not matter. What was intended
(but was not implemented) is for $search_regexp to matter and to
be used only if $searchtext is defined.  $searchtext is reset on each
request, so $search_regexp should be also reset... like in Charles's
patch.

Anyway in the analysis below we need to check if code checks
$searchtext first.

>  * esc_html_match_hl and esc_html_match_hl__chopped (called from
>    git_project_list_rows, for example) want to have "undef"; an
>    empty string will not do.
>
>  * search_projects_list (called from git_project_list_body)
>
>  x git_search_files and git_search_grep_body assume that
>    $search_regexp can be interpolated in m//, which is not very
>    nice.  They want an empty string.

But both git_search_files() and git_search_grep_body() are run from
git_search(), which "dies" (returns HTTP 400 "Text field is empty" error)
if $searchtext is not defined; if $searchtext is defined then $search_regexp
is string and is never undef.

> So as an independent fix, the two subs may want to be fixed if we
> want to be undef clean.  Or am I missing something?  Jakub, isn't
> this kind of "undef" reference t9500 was designed to catch?
>
>>  gitweb/gitweb.perl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 80950c0..8d69ada 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1086,7 +1086,7 @@ sub evaluate_and_validate_params {
>>       our $search_use_regexp = $input_params{'search_use_regexp'};
>>
>>       our $searchtext = $input_params{'searchtext'};
>> -     our $search_regexp;
>> +     our $search_regexp = undef;
>>       if (defined $searchtext) {
>>               if (length($searchtext) < 2) {
>>                       die_error(403, "At least two characters are required for search parameter");

-- 
Jakub Narebski
