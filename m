From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v16 05/14] ref-filter: introduce match_atom_name()
Date: Mon, 7 Sep 2015 23:37:35 +0530
Message-ID: <CAOLa=ZSscCk77f4viVPUhXRhpFXF=fa8c=G9mF0RovRqKqeLmg@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
 <1441479135-5285-6-git-send-email-Karthik.188@gmail.com> <CAPig+cSN1s6qAj7p_+qG9W52X2L-7eBR+-j+918vfycADvUyWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 20:08:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ0pw-0004hL-5o
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 20:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbbIGSIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 14:08:07 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35268 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbIGSIG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 14:08:06 -0400
Received: by obuk4 with SMTP id k4so66702726obu.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KakyOfDrcqEgGYQExLYRM6dPBINqRPN+wiaVdB62Aik=;
        b=qWEO6CtBVhydO7AqGqLOngEwsVkPlJGZbBvf86WEJvsM7BeuAcqu6+NYY9PGw6G0PQ
         wTtiEz9qJFFLOxrlM+J+rSyyJlX4Ct/QHhzVLMs7H0c/+Fv198lHfN+d+1TbNCyY7AIz
         dJ9Swg3VqEWPfrrUWNaZ6i8dV0Eog1gqOpnTrhD/qdBEpWfoSKvZHJwci4cL4Jrxjs7u
         nt0Z7b/DlSUmSOamUvTq13o+b05PMj2PtH//voDfVx1HX+hBSkaQtSiXoL6Yhef0RGae
         y2L5lZlWntW8FhlLu5TXe+dHvGq1apjycCTJ27l9z5u2etzjZWdFA9UMETCbVRuYF2qb
         XObQ==
X-Received: by 10.60.43.105 with SMTP id v9mr15594324oel.1.1441649284394; Mon,
 07 Sep 2015 11:08:04 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 7 Sep 2015 11:07:35 -0700 (PDT)
In-Reply-To: <CAPig+cSN1s6qAj7p_+qG9W52X2L-7eBR+-j+918vfycADvUyWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277472>

On Mon, Sep 7, 2015 at 1:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Sep 5, 2015 at 2:52 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce match_atom_name() which helps in checking if a particular
>> atom is the atom we're looking for and if it has a value attached to
>> it or not.
>>
>> Use it instead of starts_with() for checking the value of %(color:...)
>> atom. Write a test for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index a993216..e99c342 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> +static int match_atom_name(const char *name, const char *atom_name, const char **val)
>> +{
>> +       const char *body;
>> +
>> +       if (!skip_prefix(name, atom_name, &body))
>> +               return 0; /* doesn't even begin with "atom_name" */
>> +       if (!body[0] || !body[1]) {
>> +               *val = NULL; /* %(atom_name) and no customization */
>> +               return 1;
>
> If this is invoked as match_atom_name("colors", "color", ...), then it
> will return true (matched, but no value), which is not correct at all;
> "colors" is not a match for atom %(color). Maybe you meant?
>
>     if (!body[0] || (body[0] == ':' && !body[1])) {
>
> But, that's getting ugly and complicated, and would be bettered
> handled by reordering the logic of this function for dealing with the
> various valid and invalid cases. However...
>

Well as you infered the logic is to check so that there is something
existing after the ':'. About why I didn't do something like this
"(body[0] == ':' && !body[1])" is because ref-filter already
checks for invalid atom names.

So before even match_atom_name() is called, the check is done in
parse_ref_filter_atom().

>> +       }
>> +       if (body[0] != ':')
>> +               return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
>> +       *val = body + 1; /* "atomname:val" */
>> +       return 1;
>> +}
>
> It's not clear why this function exists in the first place. It's only
> purpose seems to be to specially recognize instances of atoms which
> should have a ":" but lack it, so that the caller can then report an
> error.
>
> But why is this better than the more generic solution of merely
> reporting an error for *any* unrecognized atom? How does it help to
> single out these special cases?
>
> There is a further inconsistency in that you are only specially
> recognizing %(color) and %(align) lacking ":", but not
> %(content:lines) lacking "=" in patch 8/14. Why do %(color:...) and
> %(align:...) get special treatment but %(content:lines=...) does not?
> Such inconsistency again argues in favor of a generic "unrecognized
> atom" detection and reporting over special case handling.
>

This is from http://article.gmane.org/gmane.comp.version-control.git/277099
Junio suggested to have this to check for ":" rather than rely on
skip_prefix() and check manually after that.

Agreed, a more generic solution would be better, and If I remember I said,
I'll work on that after this entire series.

About contents:lines, we declare contents:lines itself as an atom, this was to
keep it similar to how the other contents atoms are declared, so the testing
for this again is already done by parse_ref_filter_atom().

-- 
Regards,
Karthik Nayak
