From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/3] count-objects: report garbage files in pack
 directory too
Date: Sat, 9 Feb 2013 08:58:23 +0700
Message-ID: <CACsJy8D1qMpLRS0nyayRc=sq2A4X-dbiXhdVdfP6OOTCkxms4Q@mail.gmail.com>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1360295307-5469-1-git-send-email-pclouds@gmail.com> <1360295307-5469-3-git-send-email-pclouds@gmail.com>
 <7vwqui1w84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 02:59:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3zio-0005Nn-93
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 02:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760508Ab3BIB6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 20:58:55 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:54578 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760472Ab3BIB6y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 20:58:54 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so4462093obb.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 17:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qs3MyXdkdpJ56MR2RNIui3WDTVKmZ/xF2KMXC+CE7oU=;
        b=AsnXzZDDxbTb+CeEUsnMF3pHKa5TJ3Nu1dFxHzpB/3WeA6DcEMCd7t6T2ciJljbNHe
         uVbxfYRypEDYjEOs5T8MiB/uNAl8LotkOggCame1u/jRJJia1ADU0g/BtSecrIbbbuEx
         CilESTj4UMosw1tgakv1LgVkSu3Mml6a85UBuvJF/uPdHoK/ma96qN62pi6hdkxcNbMP
         mRa9xmVpWtLmNMhNJY9kaXAN/7VOecz8rtuIbADbxIB8NDKy+5eJtiipq6wwLH4fhv8O
         emU8cS84b2rdi3FhXnA436Vq9REF1bt6Lvh4T4pf8UdzRzfu1FsHnw3MAZ7zUDR4WkUe
         vswQ==
X-Received: by 10.60.8.65 with SMTP id p1mr5968124oea.4.1360375133914; Fri, 08
 Feb 2013 17:58:53 -0800 (PST)
Received: by 10.182.129.46 with HTTP; Fri, 8 Feb 2013 17:58:23 -0800 (PST)
In-Reply-To: <7vwqui1w84.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215843>

On Sat, Feb 9, 2013 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +static void real_report_pack_garbage(const char *path, int len, const char *name)
>> +{
>
> Don't some callers call this on paths outside objects/pack/
> directory?  Is it still report-pack-garbage?

In fact 3/3 uses it to report loose garbage. Will rename.

>> +static const char *known_pack_extensions[] = { ".pack", ".keep", NULL };
>
> This sounds wrong.  Isn't ".idx" also known?

I had a comment saying "all known extensions related to a pack, except
.idx" but I dropped it. .idx being used as the pointer file needs to
be handled separately.

>> @@ -1024,14 +1074,37 @@ static void prepare_packed_git_one(char *objdir, int local)
>>               int namelen = strlen(de->d_name);
>>               struct packed_git *p;
>>
>> -             if (!has_extension(de->d_name, ".idx"))
>> +             if (len + namelen + 1 > sizeof(path)) {
>> +                     if (report_pack_garbage)
>> +                             report_pack_garbage(path, len - 1, de->d_name);
>
> A pack/in/a/very/long/path/pack-0000000000000000000000000000000000000000.pack
> may pass when fed to "git verify-pack", but this will report it as "garbage",
> without reporting what is wrong with it.  Wouldn't that confuse users?

If all other git commands do not recognize the pack, then I think it's
still considered garbage. We could either

 - make prepare_packed_git_one accept pack/in/a/very/long/path-...
 - show the reason why we consider it garbage

Which option do we do? Option 1 may involve chdir in, stat stat stat
and chdir out to get around short PATH_MAX limit on some system.

>> -             if (len + namelen + 1 > sizeof(path))
>> +             if (!has_extension(de->d_name, ".idx")) {
>> +                     struct string_list_item *item;
>> +                     int i, n;
>> +                     if (!report_pack_garbage)
>> +                             continue;
>> +                     if (is_dot_or_dotdot(de->d_name))
>> +                             continue;
>> +                     for (i = 0; known_pack_extensions[i]; i++)
>> +                             if (has_extension(de->d_name,
>> +                                               known_pack_extensions[i]))
>> +                                     break;
>> +                     if (!known_pack_extensions[i]) {
>> +                             report_pack_garbage(path, 0, NULL);
>> +                             continue;
>> +                     }
>> +                     n = strlen(path) - strlen(known_pack_extensions[i]);
>> +                     item = string_list_append_nodup(&garbage,
>> +                                                     xstrndup(path, n));
>> +                     item->util = (void*)known_pack_extensions[i];
>>                       continue;
>> +             }
>
> Why isn't this part more like this?
>
>                 if (dot-or-dotdot) {
>                         continue;
>                 } else if (has_extension(de->d_name, ".idx")) {
>                         do things for the .idx file;
>                 } else if (has_extension(de->d_name, ".pack") {
>                         do things for the .pack file, including
>                         queuing the name if we haven't seen
>                         corresponding .idx for later examination;
>                 } else if (has_extension(de->d_name, ".keep") {
>                         nothing special for now but we may
>                         want to add some other checks later
>                 } else {
>                         everything else is a garbage
>                         report_pack_garbage();
>                 }

Originally I checked known_extensions again in report_pack_garbage()
but after restructuring, yeah we can drop known_extensions and do it
your way. Looks much clearer.
-- 
Duy
