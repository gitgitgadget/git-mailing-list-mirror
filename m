From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH] commit -v: strip diffs and submodule shortlogs from
 the commit message
Date: Sun, 17 Nov 2013 13:20:45 +0100
Message-ID: <5288B49D.8080401@web.de>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de> <loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de> <5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de> <xmqqy54tfeje.fsf@gitster.dls.corp.google.com> <5283C701.8090400@web.de> <xmqq7gccdq67.fsf@gitster.dls.corp.google.com> <5287F735.3030306@web.de> <20131117090935.GC17016@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 17 13:20:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vi1LU-0003lS-Qq
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 13:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab3KQMUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 07:20:54 -0500
Received: from mout.web.de ([212.227.15.14]:55064 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab3KQMUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 07:20:52 -0500
Received: from [192.168.178.41] ([91.3.128.91]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0M8hxz-1VVZ0D14Ff-00wCKh for <git@vger.kernel.org>; Sun,
 17 Nov 2013 13:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131117090935.GC17016@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:+4Uab/PLiaanzd53Eei66HKXUoYj0Zeek80B1FmgtofnAdVgMf1
 9RJRufiLpI0LabmdUqRDWP5iS2qHJERPmOCCmDycT0NoQb106XKpnuHQFAGerYkOCXWEz7j
 qFaw5YXvNMojCQlnKPl1ldVU5RsZvh2OGekMCpUyy0GTNC85WA6s6JSot5B/Zl0OFnWIGe3
 pEq6C6RAVopLXE5m8N2QA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237960>

Am 17.11.2013 10:09, schrieb Jeff King:
> 
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 6ab4605..091a6e7 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1602,9 +1602,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>
>>  	/* Truncate the message just before the diff, if any. */
>>  	if (verbose) {
>> -		p = strstr(sb.buf, "\ndiff --git ");
>> -		if (p != NULL)
>> -			strbuf_setlen(&sb, p - sb.buf + 1);
>> +		p = strstr(sb.buf, wt_status_diff_divider);
>> +		if ((p != NULL) && (p > sb.buf) && (p[-1] == '\n'))
>> +			strbuf_setlen(&sb, p - sb.buf);
> 
> I think your check for a preceding newline is too strict. If I delete
> everything before the scissor line (e.g., because I am trying to abort
> the commit), we should still remove the diff. With your patch, we do
> not, and a commit message consisting solely of the diff.
> 
> So I think you want:
> 
>   if (p && (p == sb.buf || p[-1] == '\n'))

Thanks for catching this, will do so in v2.

>> +	fprintf(s->fp, _("# The diff below will be removed when keeping the previous line.\n"));
> 
> I found this hard to parse, I think because of the "keeping" (why would
> I not keep it?), and because you are talking about lines above and
> below. It is not as accurate to say:
> 
>   # ------------------ >8 --------------------
>   # Everything below this line will be removed.
> 
> because it is technically the line above that is the cutoff. But I think
> the meaning is clear, and it is simpler to parse.

Ok.

> I do think it would be simpler with a single line. I know handling the
> i18n was a question there, but I think we should be fine as long as we
> check for the exact bytes we wrote. Surely gettext can do something
> like:
> 
>   magic = _("# Everything below this line will be removed");
>   fprintf(fh, "%s", magic);
>   ...
>   p = strstr(magic);
> 
> I don't know what guarantees on string lifetime gettext gives us, but
> the worst case is that we simply strdup the result.
> 
> I suppose it's possible that the translated string could have utf8 with
> multiple representations, and the user's editor normalizes the text in a
> different way than we wrote it when it saves the result. I don't know if
> that is worth caring about or not; it seems kind of insane.

I don't have any strong feelings about this one. I'd be fine with
dropping the scissor line and taking the translated string as divider
line. What do others think?
