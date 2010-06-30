From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] bundle: use libified rev-list --boundary
Date: Wed, 30 Jun 2010 15:34:51 -0500
Message-ID: <20100630203451.GC23400@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
 <20100626062005.GC15881@burratino>
 <7vtyok5rpl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org,
	554682@bugs.debian.org, Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 22:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU40D-0000I4-Hw
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 22:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab0F3UfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 16:35:20 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64455 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab0F3UfS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 16:35:18 -0400
Received: by pxi14 with SMTP id 14so59681pxi.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mJuf5kuz7ZdjYyJ0e6PHvFxLo/mXWHuBOPS5GmB7pSo=;
        b=vUYZ/58PZe0lKhu0RMIValZNEWjJRFjqUvQBQN3C4oxjKrUrAvqBYOljWyxm0CzS6k
         p3ZCcHv8lG/o7TCG41+u+viwpx/PX9pxWWgKRAfCtJa8u6yRv8eE/3v/T7L4Z0dBg0Tq
         kjdeztXu/ZdK4Q87B78BI9FxjT8ndsB3Gn294=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QoN4FTQnqfDzAbceB+PPV0P6SSXsipl34hfbSJWdW2kTRAR5JvP8KnOJ/YhiLWVUaz
         M6PRImfJda53oYKtWV9DLbhCBgcbDsRqMul5rENNa4lFINOaxkmEXo/hTNzAD8PBGGH5
         52iUecL9TOThOTzVmUyrnjcU8vbqg0UaqqzWQ=
Received: by 10.142.121.4 with SMTP id t4mr10894191wfc.286.1277930116280;
        Wed, 30 Jun 2010 13:35:16 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm26842095ibh.14.2010.06.30.13.35.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 13:35:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtyok5rpl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149992>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The revision walker produces structured output, which should be a
>> little easier to work with than the text from rev-list.
>
> Hmm, doesn't it negatively affect later traversal you would need to d=
o if
> you smudged the flag bits by running revision traversal like this?

I imagine so.  I fear this would be the first git command to use the
revision walker twice, and I am not sure whether we can really make tha=
t
work.

The revision walker uses object flags for the following purposes:

 - marking objects uninteresting/SYMMETRIC_LEFT.  Luckily for us, if
   an object is uninteresting or SYMMETRIC_LEFT for the first
   --boundary walk, it will be likewise for pack-objects, too.

 - history simplification (TREESAME), --cherry-pick (SHOWN),
   --merge (SYMMETRIC_LEFT).  There are already other reasons to
   disallow these features for bundle.

 - add_parents_to_list (ADDED, SEEN).  This one is really worrisome;
   should we walk through again to throw away the added parents?
   Should there be a pass through all revisions to clear the ADDED
   bit?

I=E2=80=99ll figure out a one-pass solution. :(

Jonathan
