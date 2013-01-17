From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 21:42:55 -0600
Message-ID: <CAEUsAPZZ7YNCBRZRj1e1ivDL__u_9v=cBJvF0sKcKWjJ1fPRTQ@mail.gmail.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
	<DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
	<20130116160131.GB22400@sigill.intra.peff.net>
	<7vfw21xde5.fsf@alter.siamese.dyndns.org>
	<20130116174325.GA27525@sigill.intra.peff.net>
	<CAEUsAPY8T9TYCrZLWB-0Mwae_NtnqqVvGwY+4jGfqh5Lh3=Dgw@mail.gmail.com>
	<20130117031100.GA7264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 17 04:51:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvgVX-0004KU-7v
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 04:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758593Ab3AQDuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 22:50:54 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56891 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab3AQDux (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 22:50:53 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn3so1920242wib.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 19:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=P6fe3npJ8x7pVC8O1SbxMaDokl839ofS0Xl7zhhLI1U=;
        b=dDUT1sViDH8ULMRevDOqMu10ebuvvIbsTc9juLssA+cOsMN6OGm9WnNAAo8yjKhvZy
         Gmy6A4N1EhfAFPUWVh9oMn1gXDtInBGcJnCEzc/oE1O7F+iis5sfKoAK8NancI+u+NJl
         JYdefzgdGn/9M+Q3EjcRzfO6nVLtt/7njNXh6X4xhfqw0ZBZ2jaFJtVNdiPnPU9pjVkW
         zOf3yxTRgRnzzRazI4eSUFsAoMcHqz5E5s6DkdmGR1/pyTDWCXXlEVgv7uvkRs6dgjck
         5y8k/zf+3vd6wGzftnQTaHvrmlRFQj02Wevoa+o3ynfCruT+cGDDD+jCOnxyQh/h4m+3
         02Vg==
X-Received: by 10.180.14.2 with SMTP id l2mr13532300wic.2.1358394175581; Wed,
 16 Jan 2013 19:42:55 -0800 (PST)
Received: by 10.216.66.71 with HTTP; Wed, 16 Jan 2013 19:42:55 -0800 (PST)
In-Reply-To: <20130117031100.GA7264@sigill.intra.peff.net>
X-Google-Sender-Auth: WLrZv4mQC8iN5gZPl0k1NTzxtXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213840>

On Wed, Jan 16, 2013 at 9:11 PM, Jeff King <peff@peff.net> wrote:
>> is_forwardable() did solve a UI issue.  Previously all instances where
>> old is not reachable by new were assumed to be addressable with a
>> merge.  is_forwardable() attempted to determine if the concept of
>> forwarding made sense given the inputs.  For example, if old is a blob
>> it is useless to suggest merging it.
>
> I think it makes sense to mark such a case as different from a regular
> non-fast-forward (because "git pull" is not the right advice), but:
>
>   1. is_forwardable should assume a missing object is a commit not to
>      regress the common case; otherwise we do not show the pull advice
>      when we probably should, and most of the time it is going to be a
>      commit

Yes, obviously this was a bug, thus the use of "attempted" above.  It
would have been better to assume a missing 'old' was potentially
forwardable to present the user with the most helpful advice.

>   2. When we know that we are not working with commits, I am not sure
>      that "already exists" is the right advice to give for such a case.
>      It is neither "this tag already exists, so we do not update it",
>      nor is it strictly "cannot fast forward this commit", but rather
>      something else.

But the reference already existing in the remote is a substantial
reason for not allowing the push in all of these cases.  You can break
this out further if you like to explain why the specific reference
shouldn't be moved on the remote, but this is even more complicated a
simple "is old reachable from new?" test.

Chris
