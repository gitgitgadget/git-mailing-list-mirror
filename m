From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Thu, 20 Nov 2014 10:17:01 -0800
Message-ID: <20141120181701.GB15945@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
 <546B2CE0.6020208@alum.mit.edu>
 <CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
 <546BA21C.9030803@alum.mit.edu>
 <xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>
 <546BB722.5020901@alum.mit.edu>
 <xmqqsihgtcyx.fsf@gitster.dls.corp.google.com>
 <CAGZ79kb3DOrL_txW-qxzd0=4sKrOiPTdSg-17_0+__wuj0TBaQ@mail.gmail.com>
 <546DC8E9.6090504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:17:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWI0-0004Iv-0D
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757699AbaKTSRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:17:03 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:53845 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbaKTSRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:17:01 -0500
Received: by mail-ig0-f177.google.com with SMTP id uq10so3286068igb.10
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MOx9JveQ2+juckCw0Ss1oV6vyecmJtP6wne48KcSkS8=;
        b=pa+K8Q2U6b24ym2NAcRMwqhYT4REelQQ0VYrhvSde9fWSgD7UOgtBNvAlOWQW0XP4D
         d1V6gUGDiNGdll19A84BpRF0jD/RrYUs/XBmF1qzqz/haw/0ON18zuYTMYeL+Twex3/Y
         O/AITZCtWN98Su2bh3tL2O0JlbPFoZF0I5et+f690I3TDorxIoYaPG7ca4fiHasq3lya
         2STp0zKnAUPbUvavtVPJBpq9P24vPF0kV6hXqpCNGMadzGGXNCQefiMvNGNnSEJ35kpQ
         fummLk9k5lz89a9xkvHw/x7sNk0UkhXf8Xos5uyCsraCxLhSVzEUhI8SH+CCGad0i58H
         0wYA==
X-Received: by 10.107.47.89 with SMTP id j86mr50860466ioo.32.1416507421287;
        Thu, 20 Nov 2014 10:17:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id g70sm1559319ioe.18.2014.11.20.10.16.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 10:16:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <546DC8E9.6090504@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty wrote:
> On 11/20/2014 12:22 AM, Stefan Beller wrote:

>> 3. Delete the reflog when the corresponding reference is deleted [1].
>>
>> also as one transaction?
>
> It would be a side-effect of committing a transaction that contains a
> reference deletion. The deletion of the reflog would be done at the same
> time that the rest of the transaction is committed, and again the
> calling code wouldn't have to explicitly worry about the reflogs.

There is "git reflog delete <ref>", for when you have logallrefupdates
disabled and had explicitly enabled reflogs for a particular ref and
now want to turn it off.

[...]
> So this design has the caller serializing all reflog entries into
> separate ref_update structs (which implies that they are held in RAM!)
> only for ref_transaction_commit() to scan through all ref_updates
> looking for reflog updates that go together so that they can be
> processed as a whole. In other words, the caller picks the reflog apart
> and then ref_transaction_commit() glues it back together. It's all very
> contrived.

I think there is a simpler and more efficient way to implement this.

transaction_update_reflog() can append to a .lock file.
transaction_commit() then would rename it into place.

There is some fuss about naming the .lock file to avoid D/F conflicts,
which is a topic for a separate message.

> I suggest that the caller only be responsible for deciding which reflog
> entries to keep (by supplying a callback function),

That could be handy.  The basic operations described before would still
be needed, though:

	create a new reflog with one entry, for new refs

	append an entry to a reflog, for ref updates (and the associated
		symref reflog update)

	copy (or rename --- that's a more minor detail) a reflog, for
		renaming refs

	delete a reflog, for "git reflog delete"

And the "filter reflog" operation you are describing is implementable
using those four operations, with no performance hit when dealing with
reflogs stored in the files backend.

Providing these operations doesn't prevent adding "filter reflog using
callback" later if it turns out to be the right operation for other
backends.  It could turn out that some other primitive operations that
are easy as an SQL operation is more useful, like "delete reflog
entry" (without iterating over the others) or "expire entries older
than <date>".  The nice thing is that adding those wouldn't break any
code using the initial four operations described above.  So this seems
like a good starting point.

[...]
> I would love to work on this but unfortunately have way too much on my
> plate right now.

Of course code is always an easy way to change my mind, when the time
comes. ;-)

Thanks,
Jonathan
