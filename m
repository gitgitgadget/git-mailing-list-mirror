From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] [v9] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Wed, 6 Feb 2008 21:35:11 +0100
Message-ID: <E2F063EE-06C5-4B85-8511-5FD4EB6FFEC9@zib.de>
References: <7vbq6u32mq.fsf@gitster.siamese.dyndns.org> <12022971582185-git-send-email-prohaska@zib.de> <7vk5lhyir6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMrAy-0001iu-3F
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901AbYBFUqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756715AbYBFUqv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:46:51 -0500
Received: from mailer.zib.de ([130.73.108.11]:49516 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505AbYBFUqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:46:51 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m16KYEUZ005184;
	Wed, 6 Feb 2008 21:34:14 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m16KYEN0007130
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 6 Feb 2008 21:34:14 +0100 (MET)
In-Reply-To: <7vk5lhyir6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72852>


On Feb 6, 2008, at 8:42 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> This repaces v9 of the patch and should be applied.
>> It contains modifications as suggested by Junio in
>> <7vbq6u32mq.fsf@gitster.siamese.dyndns.org>
>>
>>     Steffen
>>
>> -- >8 --
>
> This v9 replaces itself, ah it repaces ;-)

Yeah, I recognized this, too; but was to lazy to send another
correction ;)


>
>> git diff, git add, and any other command that calls
>> index_fd(..., write_object=1) also behave as requested by
>> safecrlf.  The user still has the chance to save her data before
>> checkout or applying the diff.
>
> "git diff" writes by calling index_fd(..., write_object=1)???
>
> I think warning in "git diff" is probably a good thing to do but
> that is not because it writes.  The warning would trigger only
> when you are comparing what you have in the work tree with
> something else, and if you get such a warning, it means what you
> can potentially commit (i.e. what you have in the work tree) is
> not "autocrlf" safe.  You would get the same warning when you
> later runn "git add" on such a file anyway, but it is nicer to
> catch the potential problem earlier.
>
> I do not know if the above "why this command should behave this
> way with respect to safecrlf" needs to be in the commit log
> message.  But I think that information should be in the
> documentation to help the end users (the end users typically do
> not have access to the commit log of git.git).
>
> The rest of the patch looked sane.  Thanks.
>
> So I'd suggest the following change to the commit log message,
> and then another patch at the end squashed into the
> Documentation/ part.
>
> If you agree with these, you can just say "Ok, amend it like
> so".  Or you can say "Here is an even better replacement."

Ok, amend it as you proposed but also squash in the following ...

-- >8 --
diff --git a/builtin-apply.c b/builtin-apply.c
index d0b3586..3b5618d 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1430,7 +1430,7 @@ static int read_old_data(struct stat *st, const  
char *path, struct strbuf *buf)
  	case S_IFREG:
  		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
  			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf, safe_crlf);
+		convert_to_git(path, buf->buf, buf->len, buf, 0);
  		return 0;
  	default:
  		return -1;
-- >8 --

... because ...

[...]

> +
> +- "git apply" to update a text file with a patch does touch the files
> +  in the work tree, but the operation is about text files and CRLF
> +  conversion is about fixing the line ending inconsistencies, so the
> +  safety does not trigger;

... now after I read this I fully understand what you meant before.
But my v9 patch does not match your description without the change
to builtin-apply.c from above.  In v9 the mechanism was still activated
in "git apply".

	Steffen
