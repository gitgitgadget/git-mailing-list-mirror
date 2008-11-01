From: "Tom Preston-Werner" <tom@github.com>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error back to client
Date: Fri, 31 Oct 2008 23:29:59 -0700
Message-ID: <b97024a40810312329o53e37fd5td82aa69634ff1e6b@mail.gmail.com>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
	 <7vy7043sy9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 07:31:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwA1A-0002S7-V8
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 07:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbYKAGaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 02:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbYKAGaE
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 02:30:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:26741 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbYKAGaB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 02:30:01 -0400
Received: by nf-out-0910.google.com with SMTP id d3so695023nfc.21
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 23:29:59 -0700 (PDT)
Received: by 10.210.22.8 with SMTP id 8mr14533522ebv.46.1225520999337;
        Fri, 31 Oct 2008 23:29:59 -0700 (PDT)
Received: by 10.210.117.11 with HTTP; Fri, 31 Oct 2008 23:29:59 -0700 (PDT)
In-Reply-To: <7vy7043sy9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99720>

On Fri, Oct 31, 2008 at 10:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tom Preston-Werner" <tom@github.com> writes:
>
>> Example
>>
>> S: ERR No matching repository.
>> C: fatal: remote error: No matching repository.
>
> I like what this tries to do.
>
> I briefly wondered if this should be restricted to the very first message
> from the other end, but I think it is not necessary.  If the remote throws
> a few valid looking "SHA-1 SP refname" lines and then said "ERR" (which
> cannot be the beginning of a valid SHA-1), we can safely and unambiguously
> declare that this is an error message from the remote end.
>
>> diff --git a/connect.c b/connect.c
>> index 0c50d0a..3af91d6 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -70,6 +70,9 @@ struct ref **get_remote_heads(int in, struct ref **list,
>>               if (buffer[len-1] == '\n')
>>                       buffer[--len] = 0;
>>
>> +             if (len > 4 && !memcmp("ERR", buffer, 3))
>
> Would matching 4 bytes "ERR " here an improvement?  You are expecting
> buffer+4 is where the message begins in die() anyway, and otherwise you
> would show the message without "N" if you got "ERRNo matching repo".

I saw several methods of testing for a specific prefix in connect.c.
Looking more closely at the source, the closest similar call is
actually the test for ACK:

	if (!prefixcmp(line, "ACK ")) {
		if (!get_sha1_hex(line+4, result_sha1)) {
			if (strstr(line+45, "continue"))
				return 2;
			return 1;
		}
	}

Explicitly testing for "ERR " (including the space) does seem like the
more correct thing to do. Would you like me to resubmit a modified
patch that uses prefixcmp()?

Tom
