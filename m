From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 12:06:50 -0800
Message-ID: <xmqqr478m6xx.fsf@gitster.dls.corp.google.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
	<CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 21:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDg5D-0006BY-VU
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 21:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbaBLUGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 15:06:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753599AbaBLUGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 15:06:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F27B36B6F4;
	Wed, 12 Feb 2014 15:06:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yID2ZKikkmAf+7Fp6q69shyzvac=; b=s5VVlF
	dF2l3fteSzUTzX+uMTM8sT5V7YNqp4XLqYYLT/UPW+xpePRd6LOwuq4WZFzCNmQO
	GShYIj5DH1RqFcOVl59UFCm0DbQyTNzop5KeG258G1HHBdBjQKBAMFVKjlBoeGC0
	heYZvfGzfH/JZ10/Mwyd73Z6sQ92u7/aJw3AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TyigSnPZpNQJzBSpw26BUXYmMU9igFK9
	xbVxhsVuIuOQSbFv3HH+nsae3QB+ba05hjeWo7ZRyzUwreCMHDry8jDZv5I3SE+4
	2c5lJkWUUGq1vFuJwysEP4ld4OIho8fm1k2/8RGkU2vQngWoy/BXdy1KNjqtixrf
	xe1v0jAFul4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBE526B6F1;
	Wed, 12 Feb 2014 15:06:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED9696B6ED;
	Wed, 12 Feb 2014 15:06:52 -0500 (EST)
In-Reply-To: <CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
	(Stefan Zager's message of "Wed, 12 Feb 2014 10:12:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 370F7AEA-9421-11E3-82C6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242020>

Stefan Zager <szager@chromium.org> writes:

> ...  I used the Very Sleepy profiler
> to see where all the time was spent on Windows: 55% of the time was
> spent in OpenFile, and 25% in CloseFile (both in win32).

This is somewhat interesting.

When we check things out, checkout_paths() has a list of paths to be
checked out, and iterates over them and call checkout_entry().

I wonder if you can:

 - introduce a version of checkout_entry() that takes file
   descriptors to write to;

 - have an asynchronous helper threads that pre-open the paths to be
   written out and feed <ce, file descriptor to be written> to a
   queue;

 - restructure that loop so that it reads the <ce, file descriptor
   to be written> from the queue, performs the actual writing out,
   and then feeds <file descriptor to be closed> to another queue; and

 - have another asynchronous helper threads that reads <file
   descriptor to be closed> from the queue and close them.

Calls to write (and preparation of data to be written) will then
remain single-threaded, but it sounds like that codepath is not the
bottleneck in your measurement, so....
