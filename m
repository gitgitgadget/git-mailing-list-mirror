From: Faiz Kothari <faiz.off93@gmail.com>
Subject: Re: [PATCH] rewrite bulk-checkin.c:finish_bulk_checkin() using strbuf
Date: Fri, 28 Feb 2014 23:57:20 +0530
Message-ID: <CAFbjVcnx41CTOV-SCGC9a91b9weNTgYoRP1+uVDukp6Z+0F_yg@mail.gmail.com>
References: <1393574305-24015-1-git-send-email-faiz.off93@gmail.com>
	<CAPig+cTXK6=LDPDii6RQyO1fiMCq0Rai5uO0JYOzunM=4c_nUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 19:27:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJS9e-00022L-QM
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 19:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaB1S1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 13:27:22 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33934 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaB1S1V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 13:27:21 -0500
Received: by mail-lb0-f179.google.com with SMTP id p9so2722870lbv.10
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 10:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rvZK4TviBdpqE21shJgTDwkW/gbYOhea0ZLJpjj0nXg=;
        b=RwJeTXFH1h+exH5AyhksSB8km5N09/YCznlrDALgchYJI4WiQK6eJtfkXWfTTr2aMn
         0cPYaiwT7qniVmwpIovZPtoMQ0GdW4R87wzVn1SUDfUav1f7hDeEy/VcQUExSNLGxQiS
         B/Kn8Dq9uYCRRdIFgw9d8K4L4yZjulb2UR0a4XmTNhim4mzN+dAa2MZgf9iZB3CtQQy2
         KMLk83mRkdVfnA67vEpdRpchTPCFDJp8L+XIZB1GwcI+wkoJ2CE1u2SFLoUwy1hQ0EFK
         qqSMaizkYviHJxPMyflg2OPoStN2xdZc9vMhBzVKOLFfKt1HVoOSz73iJvtWlClxxflP
         OE2w==
X-Received: by 10.112.160.161 with SMTP id xl1mr2107444lbb.71.1393612040318;
 Fri, 28 Feb 2014 10:27:20 -0800 (PST)
Received: by 10.114.186.35 with HTTP; Fri, 28 Feb 2014 10:27:20 -0800 (PST)
In-Reply-To: <CAPig+cTXK6=LDPDii6RQyO1fiMCq0Rai5uO0JYOzunM=4c_nUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243000>

Hi,
Thanks for the suggestions and remarks.
I rewrote bulk-checkin.c:finish_bulk_checkin() using strbuf. But saw
that Sun He has already implemented the same way I have done.
Should I submit my implementation as a patch?

Secondly,
I tried implementing this WITHOUT changing the prototype of the
function pack-write.c:finish_tmp_packfile().

For this I detached the buffer from strbuf in finish_bulk_checkin()
using strbuf_detach() and passed it to finish_tmp_packfile().

Inside finish_tmp_packfile, I attached the same buffer to a local
struct strbuf using strbuf_attach().
Now the problem is, two of the arguments to strbuf_attach() are
'alloc' and 'len' which are private members of the struct strbuf.
But since I am just passing the detached buffer, the information of
alloc and len is lost which is required at the time of attaching.
I cannot think of any better way of using strbuf and NOT modify the
prototype of finish_tmp_packfile()

As a workaround, I can determine alloc = (strlen(buf) + 1) and len =
strlen(buf) but AFAIK this is not always true and may break.
Any suggestions?

Thanks.

On Fri, Feb 28, 2014 at 2:45 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Feb 28, 2014 at 2:58 AM, Faiz Kothari <faiz.off93@gmail.com> wrote:
>> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
>>
>> Notes:
>>     I finally got what's happening, and why the errors were caused.
>>     packname is supposed to contain the complete path to the .pack file.
>>     Packs are stored as /path/to/<SHA1>.pack which I overlooked earlier.
>>     After inspecting what is happening in pack-write.c:finish_tmp_packfile()
>>     which indirectly modifies packname by appending the SHA1 and ".pack" to packname
>>     This is happening in these code snippets:
>>         char *end_of_name_prefix = strrchr(name_buffer, 0);
>>
>>     and later
>>         sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
>>
>>     name_buffer is packname.buf
>>     Using const for the first argument of pack-write.c:finish_tmp_packfile()
>>     doesnot raise any compile time warning or error and not any runtime errors,
>>     since the packname.buf is on heap and has extra space to which more char can be written.
>>     If this was not the case,
>>         for e.g. passing a constant string and modifying it.
>>         This will result in a segmentation fault.
>> ---
>
> This notes section is important to the ongoing email discussion,
> however, it should be placed below the "---" line so that it does not
> become part of the recorded commit message when the patch is applied
> via "git am".
>
>>  bulk-checkin.c |    8 +++++---
>>  pack-write.c   |    2 +-
>>  pack.h         |    2 +-
>>  3 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/bulk-checkin.c b/bulk-checkin.c
>> index 118c625..bbdf1ec 100644
>> --- a/bulk-checkin.c
>> +++ b/bulk-checkin.c
>> @@ -23,7 +23,7 @@ static struct bulk_checkin_state {
>>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>  {
>>         unsigned char sha1[20];
>> -       char packname[PATH_MAX];
>> +       struct strbuf packname = STRBUF_INIT;
>>         int i;
>>
>>         if (!state->f)
>> @@ -42,9 +42,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>                                          state->offset);
>>                 close(fd);
>>         }
>> +       strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
>> +       strbuf_grow(&packname, 40 + 5);
>
> There are several problems with this. First, magic numbers 40 and 5
> convey no meaning to the reader. At the very least, they should be
> named constants or a comment should explain them. More seriously,
> though, this code is fragile since it has far too intimate knowledge
> of the inner workings of finish_tmp_packfile(). If the implementation
> of finish_tmp_packfile() changes in the future such that it writes
> more than 45 additional characters to the incoming buffer, this will
> break.
>
> Rather than coupling finish_bulk_checkin() and finish_tmp_packfile()
> so tightly, consider finish_tmp_packfile() a black box which just
> "does its job" and then propose ways to make things work without
> finish_bulk_checkin() having to know how that job is done.
>
>> -       sprintf(packname, "%s/pack/pack-", get_object_directory());
>> -       finish_tmp_packfile(packname, state->pack_tmp_name,
>> +       finish_tmp_packfile(packname.buf, state->pack_tmp_name,
>>                             state->written, state->nr_written,
>>                             &state->pack_idx_opts, sha1);
>>         for (i = 0; i < state->nr_written; i++)
>> diff --git a/pack-write.c b/pack-write.c
>> index 605d01b..ac38867 100644
>> --- a/pack-write.c
>> +++ b/pack-write.c
>> @@ -336,7 +336,7 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
>>         return sha1fd(fd, *pack_tmp_name);
>>  }
>>
>> -void finish_tmp_packfile(char *name_buffer,
>> +void finish_tmp_packfile(const char *name_buffer,
>
> This is misleading and fragile. By specifying 'const',
> finish_tmp_packfile() promises not to modify the content of the
> incoming name_buffer, yet it breaks this promise by modifying the
> buffer through the non-const end_of_name_prefix variable (after
> dropping the 'const' via strrchr()).
>
>>                          const char *pack_tmp_name,
>>                          struct pack_idx_entry **written_list,
>>                          uint32_t nr_written,
