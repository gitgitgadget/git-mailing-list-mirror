From: Domain Admin <daniel@dbingham.com>
Subject: Re: [PATCH] git-p4: Fetch the proper revision of utf16 files
Date: Fri, 3 Apr 2015 15:49:01 -0700
Message-ID: <CAFzU1RLqQ6WPJuxQMjBOmASoNauMv5StW-rC6d6DuL6EiOHUPQ@mail.gmail.com>
References: <1428095627-8772-1-git-send-email-git@dbingham.com>
	<1428095627-8772-2-git-send-email-git@dbingham.com>
	<CAPig+cT59B-ccvbfyPvVt_1dTO7jFPn7YQdhu81WSz_1WFM2GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:49:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeAOi-0007LH-Fs
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbbDCWtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:49:04 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34490 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbbDCWtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:49:02 -0400
Received: by qgfi89 with SMTP id i89so18502783qgf.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 15:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oCiizDDx+b8M7fwh2HMOTYiCpq9GxQhZ9RSnvEEv6vk=;
        b=DwhXG33IidW4JKvKUwksypWfTazvP6CahRulV/pIw1HERBSfZk2TMhRXilwsVWTiLD
         bI/cLgCqMd4+lDjji5iczuKGVgmWbQNlK1c38SpTDvGkI2b1a972DpEMWbbEHfTGaoyi
         TVDyzsRO4AUSRAvXaG3D84mKE47EN9mL6ETxm8TsBwvL1CBwbnwzfOo7R5GgWs2WIoLY
         KAme2QQjw38tLsktxUkZmOBuFNJu7HzWCpZ5cZ5o1NbSzTF7KpeEcWvxTgVf2Yfk4Tfu
         7bMTCxzG3Eyvv4NkoGcaXLw7agIDla4dN/EE5yes8kp213Z0cVXKYUC5P185Il6X0wRs
         ZPEA==
X-Gm-Message-State: ALoCoQle9kJF8yvlmPk8GS63TH1DFvbGoqqXA5DSmxUgPtntaTec6tDpddFlEMyKSfyernx59px6
X-Received: by 10.55.55.75 with SMTP id e72mr8511797qka.30.1428101341127; Fri,
 03 Apr 2015 15:49:01 -0700 (PDT)
Received: by 10.140.198.69 with HTTP; Fri, 3 Apr 2015 15:49:01 -0700 (PDT)
In-Reply-To: <CAPig+cT59B-ccvbfyPvVt_1dTO7jFPn7YQdhu81WSz_1WFM2GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266745>

*note* I tried to send this to the list earlier but forgot to set the
mode to plain-text so it got rejected.  Resending.  Apologies for any
duplicates.

I think the context of the patch doesn't make this clear, but if you
look at git-p4.py in this spot you'll see that this is in a block that
begins:

if type_base == "utf16":

Where "type_base" is extracted, by the script, from the filetype
provided by p4 (i.e. metadata provided by p4). In the particular
scenario I encountered, P4 said that the file was of type xutf16 from
which the split_p4_type() method extracts "utf16" as the type_base.

The essence of the issue here has nothing to do with UTF16, its just
coincidental that it happens for files of that type.  The problem is
that the script wasn't requesting the proper revision from P4 and thus
would always get the *latest* revision.  This corrects that by having
the script request the appropriate revision from P4.

Daniel

On Fri, Apr 3, 2015 at 2:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Apr 3, 2015 at 5:13 PM, Daniel Bingham <daniel@dbingham.com> wrote:
>> git-p4 always fetches the latest revision of UTF16
>> files from P4 rather than the revision at the commit being sync'd.
>>
>> The print command should, instead, specify the revision number from the
>> commit in question using the file#revision syntax.
>>
>> The file#revision syntax is preferable over file@changelist for
>> consistency with how streamP4Files formats the fileArgs list.
>
> As a non-Perforce reader trying to understand this patch, there are a
> couple issues which are unclear or inadequately explained. Perhaps you
> could provide a bit more detail or cite relevant sources.
>
> First, does "UTF16 file" refer to the content or the filename?
>
> Second, I may be entirely missing it, but the commit message doesn't
> seem to explain why this impacts only "UTF16 files", and why this
> solution is the appropriate fix.
>
> If the answer to the first question is that the filename is UTF-16,
> then would an alternate fix be to convert the value of
> file['depotFile'] to have the same encoding as the "print -q -o - ..."
> command-line? (Again, please excuse my Perforce-ignorance if I'm
> completely off the mark.)
>
>> Signed-off-by: Daniel Bingham <git@dbingham.com>
>> ---
>>  git-p4.py | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index ff132b2..156f3a4 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2101,7 +2101,8 @@ class P4Sync(Command, P4UserMap):
>>              # them back too.  This is not needed to the cygwin windows version,
>>              # just the native "NT" type.
>>              #
>> -            text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
>> +            ufile = "%s#%s" % (file['depotFile'], file['rev'])
>> +            text = p4_read_pipe(['print', '-q', '-o', '-', ufile])
>>              if p4_version_string().find("/NT") >= 0:
>>                  text = text.replace("\r\n", "\n")
>>              contents = [ text ]
>> --
>> 2.3.5
