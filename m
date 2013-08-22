From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 17:59:28 -0400
Message-ID: <CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	<xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 23:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCcuj-0006Hi-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 23:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab3HVV7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 17:59:30 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:63221 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab3HVV73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 17:59:29 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so4614565obc.24
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YmM/Em3UejW483U4J3iaRL5fO7FBu+9sxhkjlGY8SN4=;
        b=XWno8/2LOZggxegbZOvkojCUlpWSP36si8wLVwVI/nKd14NSet/iQle0rIpExJUWTy
         adOqa7EMlszwEW88l82rmg7TQ+OkqYD4gxrBn63b0Kvq0ht2LEqz5q4rpDZ4CO2uEMxV
         /TyqVpriDdrbLJHq1Q/eO9JXKRO5EN2HGN+OAa6O0ImtnbOzaYnXrWRGeUtnao0TjZI7
         13NDGy7GvO+w5AOi7fUDe4fOXVvv5sdHckLR/M4LnUsoyZ3adYNvVOGdVoVwjz3BBavA
         16bKHHufNqFEPxXtuvZPObu4raJb6JQ3h1xxwNVixlS0KvJEHT+Nse9rwcFfP26wtUDR
         /ktA==
X-Received: by 10.182.128.6 with SMTP id nk6mr17093771obb.11.1377208768713;
 Thu, 22 Aug 2013 14:59:28 -0700 (PDT)
Received: by 10.182.224.167 with HTTP; Thu, 22 Aug 2013 14:59:28 -0700 (PDT)
In-Reply-To: <xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: X6tIkzM2emHhE1QCX_fOTGnZB6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232783>

On Thu, Aug 22, 2013 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Thu, Aug 22, 2013 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Now, I am curious how it breaks on OS X.
>>>
>>> My suspition is that "ignore_case" may have something to do with it,
>>> but what 2eac2a4c (ls-files -k: a directory only can be killed if
>>> the index has a non-directory, 2013-08-15) uses are the bog-standard
>>> cache_name_exists() and directory_exists_in_index(), so one of these
>>> internal API implementation has trouble on case insensitive
>>> filesystems, perhaps?  I dunno.
>>
>> That's exactly my suspicion at the moment. It's an obvious difference
>> between Linux and OS X. I'm just in the process of trying to compare
>> between the two platforms.
>
> Or perhaps de->d_type does not exist?  In such a case, we end up
> doing get_index_dtype() via get_dtype(), but in this codepath I
> suspect that we do not want to.  We are interested in the type of
> the entity on the filesystem.

de->d_type exists on both platforms. get_dtype() is never called.

However, I did discover that treat_path() is being invoked fewer times
on OSX than on Linux. For instance, in the repository created by
t3010, treat_path() is called 19 times on Linux, but only 17 times on
OSX.
