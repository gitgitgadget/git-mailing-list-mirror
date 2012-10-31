From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Wed, 31 Oct 2012 02:23:08 +0100
Message-ID: <CAMP44s3pZsDa8w46JWmxFt=BdrxDxnB_r1p50p7eOiaVcjNs-w@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
	<20121030185914.GI15167@elie.Belkin>
	<20121031005748.GW15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:23:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTN1f-000361-MK
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 02:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab2JaBXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:23:11 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39808 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab2JaBXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:23:09 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so941914oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hOGoFGpHB/gvT8MlSxfFSd+MygPSgYlAwBFOahfrHGk=;
        b=aHspvsextnlsNZ0v/4so2ERBLwSwWX3rAEZOloyZC640oK6IRyQ084EuepuJRwn032
         i8RgXKk9WRYRpRiYQ1pSNswP/w2JjFebpSJIQlmaR+2lfC8y5PLqRMS6cox4g4P/TmfS
         LZN+xzjGlPqfqtF15gCzS0QZrktVhup6rUbTElMw3Ptn9vcFxHLqNxjA4r8jS2IlE7N1
         ILW8LkPnaX287PAGO8czcxXs9v2QbpumXH2nb/elGA4qCGzK+G3ceQrBBnUTiOBAG8w8
         yYLomIaNLMaNsS5k9QP15FJ/i8XjgPWvCR25fF434mayaJVmWZ9kPPcs1cx6dwhA+0Az
         eIgA==
Received: by 10.182.116.6 with SMTP id js6mr28897932obb.82.1351646588934; Tue,
 30 Oct 2012 18:23:08 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 18:23:08 -0700 (PDT)
In-Reply-To: <20121031005748.GW15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208777>

Hi,

On Wed, Oct 31, 2012 at 1:57 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> They have been marked as UNINTERESTING for a reason, lets respect that.
>
> So, the above description conveyed zero information, as you mentioned.

I meant, this, of course:
>> They have been marked as UNINTERESTING for a reason, lets respect that.
>
> This patch looks unsafe,

Which you know, because you received that message without the mistake.

> A clearer explanation would be the following:
>
>         fast-export: don't emit "reset" command for negative refs

What is a negative ref?

>         When "git fast-export" encounters two refs on the commandline

commandline?

Only two refs? How about four?

>         referring to the same commit, it exports the first during the usual
>         commit walk and the second using a "reset" command in a final pass
>         over extra_refs:

That is not exactly true: (next^{commit}).

>                 $ git fast-export master next
>                 reset refs/heads/master
>                 commit refs/heads/master
>                 mark :1
>                 author Jonathan Nieder <jrnieder@gmail.com> 1351644412 -0700
>                 committer Jonathan Nieder <jrnieder@gmail.com> 1351644412 -0700
>                 data 17
>                 My first commit!
>
>                 reset refs/heads/next
>                 from :1

I don't think this example is good. Where does it say that 'next'
points to master? Using 'points-to-master' or a 'git branch stable
master' and using 'master stable'.

Even simpler would be to use 'git fast-export master master'; it would
show the same behavior.

>         Unfortunately the code to do this doesn't distinguish between positive
>         and negative refs, producing confusing results:
>
>                 $ git fast-export ^master next
>                 reset refs/heads/next
>                 from :0
>
>                 $ git fast-export master ^next
>                 reset refs/heads/next
>                 from :0
>
>         Use revs->cmdline instead of revs->pending to iterate over the rev-list
>         arguments, checking the UNINTERESTING flag bit to distinguish between
>         positive (master, --all, etc) and negative (next.., --not --all, etc)
>         revs and avoid enqueueing negative revs in extra_revs.

Use what? You mean, "To solve the problem, lets use".

But this is not correct, cmdline is not being used. Have you even
looked at the patch?

>         This does not affect revs that were excluded from the revision walk
>         because pointed to by a mark, since those use the SHOWN bit on the
>         commit object itself and not UNINTERESTING on the rev_cmdline_entry.

revs? You mean commits?

"excluded because point to by a mark"? Doesn't sound like proper
grammar. Maybe "excluded because they were pointed to by a mark".

And I don't see why this paragraph is needed at all. Why would the
reader think marks have anything to do with this? There's no mention
of marks before.

This might help you, or other people involved in the problem, but not
anybody else. Anything related to marks is completely orthogonal to
this patch, and there's no point in mentioning that.

-- 
Felipe Contreras
