From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Thu, 10 Jul 2008 07:33:55 -0700
Message-ID: <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
	 <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>
	 <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>
	 <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>
	 <alpine.DEB.1.00.0807101526380.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 16:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGxEZ-0004ka-R9
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 16:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758466AbYGJOd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 10:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758457AbYGJOd5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 10:33:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:49166 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758448AbYGJOd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 10:33:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4007687rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=pjm4hGdjClFvTT5X6/UfpZEBXlhI6pZ6/uQ+hOznPB4=;
        b=uNqSTLah/l6VQgh5KKOgF++vm0ZYwb6jFdmOhJxjwhnCBIAfNhSxnQI5IuZZyD4orB
         Eqm0yVfVuCqKIjUvXsgL3rwW27hQoKb3nxyrirECc81nj1WE7eqVuhc37IDkHerTN+RS
         uBRWNrQdwI7oNwBNIcyqDvYdHj7FiTQcTfBtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=L1RiTcnXEI4W+LX9CgMdPxT5C4uD1RNyrbcUbpJcBvheQLhkVbM7azFhH6XH8WEbQl
         obeeEGE55CqHKaeymGaFEr/d/Gklro0SrcvuVvf6ofwBzmXoSfbs0uCf1GDlcrSMP3hP
         DiyxzH/GI5dmAjin0YtmaIHbvilym5WPcRANE=
Received: by 10.140.170.12 with SMTP id s12mr4828006rve.101.1215700436036;
        Thu, 10 Jul 2008 07:33:56 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Thu, 10 Jul 2008 07:33:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807101526380.18205@racer>
Content-Disposition: inline
X-Google-Sender-Auth: 827fa102c59410bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87977>

On Thu, Jul 10, 2008 at 7:28 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 10 Jul 2008, Geoffrey Irving wrote:
>
>> On Wed, Jul 9, 2008 at 8:34 PM, Geoffrey Irving <irving@naml.us> wrote:
>>
>> > Note: there are at least two "holes" in this code.  First, it is
>> > impossible to verify the validity of the entries (this is impossible
>> > to fix).  Second, it is possible to write a malicious patch-id-cache
>> > file that causes git-cherry to go into an infinite loop.  Fixing the
>> > loop requires either traversing every entry on load (bad) or adding a
>> > second loop termination condition to find_helper.  Since looping
>> > forever is better than returning incorrect results, I figured fixing
>> > the weaker hole would just result in a false sense of security.
>>
>> Oops: avoiding the infinite loop only requires reading expected O(1)
>> entries on load, so I can fix that if you like.  It would only be all of
>> them if it actually did detect the infinite loop.
>
> I have to admit that you lost me there.  AFAIR the patch-id cache is a
> simple commit->patch_id store, right?  Then there should be no way to get
> an infinite loop.

If every entry is nonnull, find_helper loops forever.

> Besides, this is a purely local cache, no?  Never to be transmitted...  So
> not much chance of a malicious attack, except if you allow write access to
> your local repository, in which case you are endangered no matter what.

Yep, that's why it's only a hole in quotes, and why I didn't fix it.

Geoffrey
