From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Oct 2013, #03; Wed, 16)
Date: Fri, 18 Oct 2013 21:52:35 +0200
Message-ID: <52619183.5010608@web.de>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>	<525FB287.7020204@gmail.com>	<xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com>	<xmqqmwm7y5bf.fsf@gitster.dls.corp.google.com>	<526083E7.6080701@gmail.com> <xmqqfvrywg4y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 21:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXG9K-0007Xr-9Z
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 21:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab3JRTzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 15:55:50 -0400
Received: from mout.web.de ([212.227.17.11]:53090 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab3JRTwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 15:52:37 -0400
Received: from [192.168.178.41] ([91.3.185.187]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LtWsu-1Vh7zD2iDU-010rcF for <git@vger.kernel.org>;
 Fri, 18 Oct 2013 21:52:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <xmqqfvrywg4y.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:CFF2NaVRjKBWQ+qfpbX3QWGN4Cv2d1CuEy9YOzyT41kvdnU2bTx
 P+vRGL0y+jXiM/JZvXA8QFAIVcgVubih9xmmeMMUkXph8w1br93wJsdYXz2zDz+8R7F7fv4
 +1DHPC058vVi62ryY6bhoURqnITQovudagsCg1E9KbohnOAnRSXUiOnn37SnxILrv8Lm1bL
 QmAbNJ9jHfEeHozyj9u6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236369>

Am 18.10.2013 21:09, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
>> Can't we just use add_file_to_cache here (which replaces
>> cache_entries by creating a copy)?
>>
>> diff --git a/submodule.c b/submodule.c
>> index 1905d75..e388487 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -116,30 +116,7 @@ int remove_path_from_gitmodules(const char *path)
>>  
>>  void stage_updated_gitmodules(void)
>>  {
>> -       struct strbuf buf = STRBUF_INIT;
>> -       struct stat st;
>> -       int pos;
>> -       struct cache_entry *ce;
>> -       int namelen = strlen(".gitmodules");
>> -
>> -       pos = cache_name_pos(".gitmodules", namelen);
>> -       if (pos < 0) {
>> -               warning(_("could not find .gitmodules in index"));
>> -               return;
>> -       }
> 
> I think the remainder is (morally) equivalent between the original
> and a single "add-file-to-cache" call, and the version after your
> "how about this" patch in the message I am responding to looks more
> correct (e.g. why does the original lstat after it has read the
> file?).

Cargo cult programming. I was looking at other code manipulating
the index (as Documentation/technical/api-in-core-index.txt is
rather terse ;-) and concluded I would need to read the possibly
updated st.st_mode, in case updating the config file would have
changed that.

> But this warning may want to stay, no?

Of course you are right on this one. All test ran successfully
with this patch, so I think adding one for that warning makes
sense too. And as that is submodule related stuff I volunteer
for fixing all this ;-)

>> -       ce = active_cache[pos];
>> -       ce->ce_flags = namelen;
>> -       if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
>> -               die(_("reading updated .gitmodules failed"));
>> -       if (lstat(".gitmodules", &st) < 0)
>> -               die_errno(_("unable to stat updated .gitmodules"));
>> -       fill_stat_cache_info(ce, &st);
>> -       ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);
>> -       if (remove_cache_entry_at(pos) < 0)
>> -               die(_("unable to remove .gitmodules from index"));
>> -       if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
>> -               die(_("adding updated .gitmodules failed"));
>> -       if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
>> +       if (add_file_to_cache(".gitmodules", 0))
>>                 die(_("staging updated .gitmodules failed"));
