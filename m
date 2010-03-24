From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 16:23:29 +0100
Message-ID: <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
	 <20100323173114.GB4218@fredrik-laptop>
	 <20100323184309.GA31668@spearce.org>
	 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
	 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Mar 24 16:23:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuSQk-0004YF-4u
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 16:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab0CXPXc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 11:23:32 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:33310 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab0CXPXb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 11:23:31 -0400
Received: by fxm23 with SMTP id 23so162766fxm.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w9ZgF5/+fXJY3FaTueLgWRu3aStouoAuz28MJsREdRw=;
        b=hYylrkZXBPjHuuXhjmVpPDSoHxkLrwXaUG00WNhvFdXKtR1FKGQiZPzNRMl1r0qLz/
         YzeB8p0qRTfF3i/cRMQujf/YEePOMSSZL9QUBd6bL5ogp9JRixOJme129mvcsWWKviRW
         94/oRCYzFi3mDqK23ROmGQC32Uph8EEJMCBVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vUa4Qbqr2ptcs39WPzybFoFc2KjrPrWCFUuglz7suHM2rjcSppDIRkZKpUNccbJYNc
         K+3a6Uz9EjT/BqAkeRfnFw9f9B+7Nl70YZYC6DCPyp6Ro4ks0rGsfcMVUu7ReaCed6cG
         1eyS4XgOxxBmZj9yxtA3hxfYenUlNuxokFuDk=
Received: by 10.239.160.75 with SMTP id b11mr2406054hbd.117.1269444209480; 
	Wed, 24 Mar 2010 08:23:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143086>

On Wed, Mar 24, 2010 at 00:50, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 23 Mar 2010, Fredrik Kuivinen wrote:
>
>> On Tue, Mar 23, 2010 at 19:43, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
>> > If that is what we are doing, disabling the release of pack window=
s
>> > when malloc fails, why can't we do that all of the time?
>>
>> The idea was that most git programs are single threaded, so they can
>> still benefit from releasing the pack windows when they are low on
>> memory.
>
> This is bobus. The Git program using the most memory is probably
> pack-objects and it is threaded. =A0Most single-threaded programs don=
't
> use close to as much memory.

Ok, you are right. But xmalloc/xrealloc cannot be used in multiple
threads simultaneously without some serialization.

=46or example, I think there are some potential race conditions in the
pack-objects code. In the threaded code we have the following call
chains leading to xcalloc, xmalloc, and xrealloc:

find_deltas -> xcalloc
find_deltas -> do_compress -> xmalloc
find_deltas -> try_delta -> xrealloc
find_deltas -> try_delta -> read_sha1_file -> ... -> xmalloc  (called
with read_lock held, but it can still race with the other calls)

As far as I can see there is no serialization between these calls.

- Fredrik
