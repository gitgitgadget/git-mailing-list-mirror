From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [RFC 1/3] sequencer: Signal failed ff as an aborted, not a conflicted
 merge
Date: Mon, 09 Jun 2014 17:04:36 +0200
Message-ID: <5395CD04.2050303@gmail.com>
References: <xmqqvbsrf4hd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Phil Hord <hordp@cisco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 17:05:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu17t-0000g8-U1
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 17:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbaFIPEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 11:04:42 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:39345 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964810AbaFIPEk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 11:04:40 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so5967272wes.18
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=K7sLc5wnspY8pc3b0CN+RtK2y1sljmtjMDpylBui6yM=;
        b=xxwElMiYTYcpA/bVs7cxOqKbZbs8rPPxJRceMANakDWNkBVcpawXTkWdMjrd9PTuym
         wE+0DEw5/ZUnM8GOmHb7RO+uhwsry1JuJazkZeBDKvfnr6r/RGVxQbwWjwh1iQCgGe+T
         bkrNRT9oXo7wsMUTiKR5S96k+x7mubfRgIWtAPV46+slM6MQGlNvWhw5OJFCkuUP8GRW
         5rHTbYxL+rk0M4NTS0mnjpcoB4RC3mGwEVhF4lavDDer544mWskBsXOsxy4DeqO7IRlA
         4ob+EDNbiTxWHxCAcMXj0Zj+yY3SXgjkYIvyXUdK1aaSeAKWi5FXlqfbVLOkx+xS4sSS
         2YjA==
X-Received: by 10.14.224.196 with SMTP id x44mr2564eep.111.1402326278928;
        Mon, 09 Jun 2014 08:04:38 -0700 (PDT)
Received: from client.googlemail.com ([2a02:8108:1bc0:1bf4:224:d7ff:fe92:3de1])
        by mx.google.com with ESMTPSA id i4sm45550545eeg.28.2014.06.09.08.04.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 08:04:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqvbsrf4hd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251080>

Hi Junio,

On 05/27/2014 08:42 PM, Junio C Hamano wrote:
> Fabian Ruch <bafain@gmail.com> writes:
>> [..]
>>
>> In order to signal the three possible situations (not only success and
>> failure to complete) after a pick through porcelain commands such as
>> `cherry-pick`, exit with a return value that is neither 0 nor 1. -1 was
>> chosen in line with the other situations in which the sequencer
>> encounters an error.
> 
> Hmph... do we still pass negative to exit() anywhere in our codebase?

No, but I thought `cmd_cherry_pick` would just forward the `return -1` from the
sequencer to the shell. I had another look and found that `cmd_cherry_pick`
calls `die` instead. Now, the commit inserts 128 as exit status in
`fast_forward_to`.

Would it be appropriate to mention the choice of exit status in the coding
guidelines? I didn't know that the int-argument to exit(3) gets truncated and
that this is why it is a general rule to only use values in the range from 0 to
255 with exit(3).

Kind regards,
   Fabian

-- >8 --
Subject: sequencer: Signal failed ff as an aborted, not a conflicted merge

`do_pick_commit` handles three situations if it is not fast-forwarding.
In order for `do_pick_commit` to identify the situation, it examines the
return value of the selected merge command.

1. return value 0 stands for a clean merge
2. 1 is passed in case of a failed merge due to conflict
3. any other return value means that the merge did not even start

So far, the sequencer returns 1 in case of a failed fast-forward, which
would mean "failed merge due to conflict". However, a fast-forward
either starts and succeeds or does not start at all. In particular, it
cannot fail in between like a merge with a dirty index due to conflicts.

In order to signal the three possible situations (not only success and
failure to complete) after a pick through porcelain commands such as
`cherry-pick`, exit with a return value that is neither 0 nor 1. 128 was
chosen in line with the other situations in which the sequencer
encounters an error. In such situations, the sequencer returns a
negative value and `cherry-pick` translates this into a call to `die`.
`die` then terminates the process with exit status 128.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 90cac7b..225afcb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -278,7 +278,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
-		exit(1); /* the callee should have complained already */
+		exit(128); /* the callee should have complained already */
 	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
 					   0, NULL);
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-- 
2.0.0
