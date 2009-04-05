From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
 efficiently lookup sha1
Date: Sun, 05 Apr 2009 13:02:30 -0700
Message-ID: <7vocvaq36x.fsf@gitster.siamese.dyndns.org>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
 <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
 <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
 <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
 <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:15:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYZw-0004Uf-He
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369AbZDEUCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbZDEUCt
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:02:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757335AbZDEUCs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:02:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CDDF2A71A6;
	Sun,  5 Apr 2009 16:02:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 55FE0A719B; Sun,
  5 Apr 2009 16:02:32 -0400 (EDT)
In-Reply-To: <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
 (Reece Dunn's message of "Sun, 5 Apr 2009 20:31:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB3375A0-221C-11DE-99F5-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115694>

Reece Dunn <msclrhd@googlemail.com> writes:

> 2009/4/5 Felipe Contreras <felipe.contreras@gmail.com>:
>> On Sun, Apr 5, 2009 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> U3ZlcnJlIFJhYmJlbGllciA8c3JhYmJlbGllckBnbWFpbC5jb20+IHdyaXRlczoNCg0KPiBPbiBT
>>> YXQsIEFwciA0LCAyMDA5IGF0IDIyOjU5LCBDaHJpc3RpYW4gQ291ZGVyIDxjaHJpc2Nvb2xAdHV4
>>> ZmFtaWx5Lm9yZz4gd3JvdGU6DQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
>>> IMKgIMKgIMKgIMKgIGlmIChsbyA8PSBtaSAmJiBtaSA8IGhpKQ0KPj4gKyDCoCDCoCDCoCDCoCDC
>>> oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazsNCj4+ICsg
>>> wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllKCJvb3BzIik7
>>> DQo+DQo+IFRoYXQncyBnb2luZyB0byBiZSBhbiBvZmZpY2lhbCBnaXQgZXJyb3IgbWVzc2FnZT8g
>>> V2h5IG5vdCBtYWtlIGl0ICJUaGUNCg0KSXQncyBub3QgImdvaW5nIHRvIGJlIiwgYnV0ICJoYXMg
>>> YmVlbiBzbyBmb3IgdGhlIGxhc3QgdHdvIHllYXJzIHNpbmNlDQo1ZDIzZTEzIi4NCg0KSXQgaXMg
>>> YW4gYXNzZXJ0LCBhbmQgSSB0aGluayBQZWZmJ3MgZGllKCJCVUc6IC4uLiIpIHdvdWxkIGJlIGEg
>>> Z29vZCBpZGVhLg0K
>>
>> Huh?
>
> I think Junio is trying to learn base64 :)!

I think that is what my Gnus/message-mode did.  I do not know which letter
triggered it to decide it is UTF-8 to begin with, though.  As far as I am
aware, I didn't type anything non-ascii in my message.
