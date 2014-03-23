From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT 06/28] Fix and simplify the do_get_patch function.
Date: Sun, 23 Mar 2014 22:03:48 +0100
Message-ID: <CAP=KgsQtJb3t1c7qK8reO6nzMJppoV-zooK16ZZcWmCirAr3ew@mail.gmail.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
	<1395387126-13681-7-git-send-email-cederp@opera.com>
	<20140323170932.GH1661@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Sun Mar 23 22:03:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRpYk-0002O2-FI
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 22:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbaCWVDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 17:03:51 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:60998 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbaCWVDt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 17:03:49 -0400
Received: by mail-ie0-f170.google.com with SMTP id rd18so4652510iec.29
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 14:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SdU/m9CQO1mdqwxUeEh5f1ZD7JjXCBcCaEiDQaFHCy8=;
        b=bJppRrS0J2udycqZroyEZ0j4+/quFjlsIXZ0k2cz7zpxACyHPEixPQIWytLBIGYA0U
         PEa9uIPOzewaiO3fwuBwOQM9gPEZDce3gCykAimJ+62H8zrICL4a7U+FTPU7IpQC21UE
         Q1KT08MMGkY5QiBmBBO5IfhFfMAHJ4P6EVI8vJLSletgsWRpkaJ5WvviTB/qMH3rd1K/
         Ge8IDsBVwm1/BAxR7r1FReQzGJ/vwzxxfSdWq+H3k9qU0hKiKA+AWX7XFQiu7zWpcVp5
         DDG6i1vmuNVfturID9I7mKC54P7vZ+RI8g5krgTFC5+hWDdlpfE+z8/7Aq/fBXXirzu5
         tX+w==
X-Gm-Message-State: ALoCoQnQ99qFKOCgLPOGryN1PaCZ7sRgx/hynbS+G185D0gN+mVcyCH0P03Sd+gyjyTpirS+l19P
X-Received: by 10.50.66.143 with SMTP id f15mr8413273igt.18.1395608628979;
 Sun, 23 Mar 2014 14:03:48 -0700 (PDT)
Received: by 10.42.44.198 with HTTP; Sun, 23 Mar 2014 14:03:48 -0700 (PDT)
In-Reply-To: <20140323170932.GH1661@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244806>

On Sun, Mar 23, 2014 at 6:09 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:

> On Fri, Mar 21, 2014 at 08:31:44AM +0100, Per Cederqvist wrote:
>> When extracting the patch, we only want the actual patches.  We don't
>> want the "---" delimiter.  Simplify the extraction by simply deleting
>> everything before the first "diff " line.  (Use sed instead of awk to
>> simplify the code.)
>>
>> Without this patch, "guilt fold" and "guilt push" sometimes fails if
>> guilt.diffstat is true.
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  guilt | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/guilt b/guilt
>> index 8701481..c59cd0f 100755
>> --- a/guilt
>> +++ b/guilt
>> @@ -332,12 +332,7 @@ do_make_header()
>>  # usage: do_get_patch patchfile
>>  do_get_patch()
>>  {
>> -     awk '
>> -BEGIN{}
>> -/^(diff |---$|--- )/ {patch = 1}
>> -patch == 1 {print $0}
>> -END{}
>> -' < "$1"
>> +     sed -n '/^diff /,$p' < "$1"
>
> So, the thought behind this mess was to allow minimal patches to work.  The
> 'diff' line is *not* required by patch(1)!

I see. I can see that this is sometimes useful, even though I think
it is more important that guilt actually works with the patches itself
creates.

> Is it a problem if a patch description contains a line that starts with
> 'diff '?  (The current code has this issue as well.)

Yes.

> For the record, this ambiguity is what's on several occasions made me
> consider splitting the header and the patch into separate files.  Yeah, it'd
> be messier.  :/

I really like having the header and the patches in the same file. I had
to solve a similar problem when I wrote my utility for diffing two diff
files (https://git.lysator.liu.se/pdiffdiff). Based on the experience I got
doing that, I propose this new do_get_patch function:

# usage: do_get_patch patchfile
do_get_patch()
{
    awk '
BEGIN {
    patchheader = ""
    patch = 0
}
patch == 1 {
    print $0
    next
}
/^(diff |index |=|RCS file:|retrieving revision )/ {
    patchheader = patchheader $0 "\n"
    next
}
/^(--- |((new|deleted) file|old) mode )/ {
    printf "%s", patchheader
  -/^(diff |---$|--- )/ {patch = 1}  print $0
    patch = 1
}
{
    patchheader = ""
}' < "$1"

}

The idea is to collect lines that *might* start the patch in
patchheader. Once we detect the start of the patch (via a
line that matches "--- " or any of the mode change lines)
we print the patcheader and the current line. If we get a
line that neither looks like a patchheader nor starts a patch,
we discard the patcheader. This is the case of a commit
message with a line that starts with "diff ".

The function above solves the issue with lines that
start with "diff " in the commit message.  On the other
hand, it introduces the same issue for lines that start
with for instance "old mode ".

Actually, a smaller change that probably fixes the
issue with diffstat is to replace

/^(diff |---$|--- )/ {patch = 1}

witih

/^(diff |--- )/ {patch = 1}

as the problem with the original implementation is that
the "---\n" line that starts the diffstat should not start
the patch.

    /ceder

>>  }
>>
>>  # usage: do_get_header patchfile
>> --
>> 1.8.3.1
>>
>
> --
> Defenestration n. (formal or joc.):
>   The act of removing Windows from your computer in disgust, usually
>   followed by the installation of Linux or some other Unix-like operating
>   system.
