From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Wed, 04 Dec 2013 12:09:09 -0800
Message-ID: <xmqqa9ggl6oq.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 21:09:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoIlP-0000sD-18
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 21:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933522Ab3LDUJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 15:09:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37498 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933521Ab3LDUJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 15:09:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA9D556AA6;
	Wed,  4 Dec 2013 15:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Obwip002raRAPLmSBX0UOhKSyc0=; b=SzODDv
	53vfBdkPXSSjWtyN28YTTLFiOqeFdOjGtIbHFmI3C+eSt+KY19HzVbx78Ulov2OY
	uha+j+TAy8T0qJYNroDsOC1qmIC1C8ZTJMLyKJLHmAEISO7+zatQSBA+hQIvQV/z
	ddlCtZEe12+359Q0xbdCA+kVg6l3c30s54mDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HEPNCtn7t2IC9MbcjX1A7YxiTdcshvqY
	Phrv0dFz1/kCv4L0GkpI49xWt8DLJZiRF9Tqmvu6DZMrg7QCVwBPYOEq/E/bOvAp
	rVk8buZNvVJmGggKDoDZMGW/jHocAvEy4PQWvhhypw7diL9IQH3xnmdZhfAfoZ+m
	4RmD5xgtRdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2EF56AA5;
	Wed,  4 Dec 2013 15:09:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCE4256AA3;
	Wed,  4 Dec 2013 15:09:13 -0500 (EST)
In-Reply-To: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 4 Dec 2013 17:53:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F212F260-5D1F-11E3-A162-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238807>

Duy Nguyen <pclouds@gmail.com> writes:

> I was thinking of an alternative to apache for testing smart-http
> so that most of http tests could always run.  Mongoose [1] looks
> like a good candidate to bundle with git. Just one pair of source
> files, mongoose.[ch], a mainloop wrapper and we have an http
> server.

Hmmmm.  How would the high-level integration look like?

 - we add contrib/mongoose/*;

 - in t/Makefile, we:

   . set GIT_TEST_HTTPD to yes, unless it is already set to another value;

   . set LIB_HTTPD_PATH to $GIT_BUILD_DIR/contrib/mongoose/mongoose,
     unless it is already set to another value;

   . if LIB_HTTPD_PATH is set to our mongoose and if it hasn't been
     built, go ../contrib/mongoose and build it.

 - we teach lib-httpd.sh to trigger the DEFAULT_HTTPD_PATH
   computation when LIB_HTTPD_PATH is set to 'system-apache', so
   that people can test with their installed apache if they choose
   to; and

 - we teach lib-httpd.sh to write out an appropriate configuration
   for the mongoose server.

That would force people to run http tests by turning it from an
opt-in option to an opt-out option.

Or were you thinking about embedding mongoose in the git executable?
