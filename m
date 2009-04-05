From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 22:19:27 +0300
Message-ID: <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
	 <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
	 <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqXuR-000111-FP
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbZDETTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbZDETTc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:19:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:47536 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872AbZDETTb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:19:31 -0400
Received: by fg-out-1718.google.com with SMTP id e12so705833fga.17
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5pg7IRD4mKdhNb4DS/fBhbEQ/CRE/87+MQ7iOCJk/40=;
        b=yHXhHkUUVGy2azpe2FbFF7QSdUBeGeGNyvpeSl1PYN9aQ74vZcsCGpLEV6fmr0ERiI
         6kbPPXxGr18w5E1sYNT6RY/WZ7j7g9FJIuYoYQxbFjrnW+DfEbaZt0o/kGonNsaMDDBx
         +99e15SbGfYKWaFX7Az2PEz/ulvZJe/8rVQlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BnZMcEr2plDW04KaD1mqlqs7DW7Uh85ykZElofBvBbiZaqsfWZl5BLYeNfc2D2oLMV
         ybfSD2axdXEmaZOX8qe6zOVrJ/IolOxgLg8b5rsHybHJDVowikD1u7gvyFMdzRFM9Xe2
         iAxwt3jxnUdD6ILkOsFCjLLwPWows3kxADFvE=
Received: by 10.86.1.1 with SMTP id 1mr2535694fga.0.1238959167803; Sun, 05 Apr 
	2009 12:19:27 -0700 (PDT)
In-Reply-To: <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115683>

On Sun, Apr 5, 2009 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> U3ZlcnJlIFJhYmJlbGllciA8c3JhYmJlbGllckBnbWFpbC5jb20+IHdyaXRlczoNCg0KPiBPbiBT
> YXQsIEFwciA0LCAyMDA5IGF0IDIyOjU5LCBDaHJpc3RpYW4gQ291ZGVyIDxjaHJpc2Nvb2xAdHV4
> ZmFtaWx5Lm9yZz4gd3JvdGU6DQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
> IMKgIMKgIMKgIMKgIGlmIChsbyA8PSBtaSAmJiBtaSA8IGhpKQ0KPj4gKyDCoCDCoCDCoCDCoCDC
> oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazsNCj4+ICsg
> wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllKCJvb3BzIik7
> DQo+DQo+IFRoYXQncyBnb2luZyB0byBiZSBhbiBvZmZpY2lhbCBnaXQgZXJyb3IgbWVzc2FnZT8g
> V2h5IG5vdCBtYWtlIGl0ICJUaGUNCg0KSXQncyBub3QgImdvaW5nIHRvIGJlIiwgYnV0ICJoYXMg
> YmVlbiBzbyBmb3IgdGhlIGxhc3QgdHdvIHllYXJzIHNpbmNlDQo1ZDIzZTEzIi4NCg0KSXQgaXMg
> YW4gYXNzZXJ0LCBhbmQgSSB0aGluayBQZWZmJ3MgZGllKCJCVUc6IC4uLiIpIHdvdWxkIGJlIGEg
> Z29vZCBpZGVhLg0K

Huh?

-- 
Felipe Contreras
