From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 00/11] writing out a huge blob to working tree
Date: Sun, 15 May 2011 17:47:58 -0700
Message-ID: <BANLkTinCRbDa1ic05SKzSOadicOKfwV04Q@mail.gmail.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 02:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLlz5-0000O3-5C
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab1EPAsT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 20:48:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58270 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1EPAsT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 20:48:19 -0400
Received: by vws1 with SMTP id 1so2816472vws.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 17:48:18 -0700 (PDT)
Received: by 10.52.180.135 with SMTP id do7mr5232518vdc.273.1305506898075;
 Sun, 15 May 2011 17:48:18 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 17:47:58 -0700 (PDT)
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173696>

On Sun, May 15, 2011 at 17:30, Junio C Hamano <gitster@pobox.com> wrote=
:
> Traditionally, git always read the full contents of an object in memo=
ry
> before performing various operations on it, e.g. comparing for diff,
> writing it to the working tree, etc. =A0A huge blob that you cannot f=
it
> in memory was very cumbersome to handle.
,,,
> Interested parties may want to measure the performance impact of the =
last
> three patches. The series deliberately ignores core.bigfileThreashold=
 and
> let small and large blobs alike go through the streaming_write_entry(=
)
> codepath, but it _might_ turn out that we would want to use the new c=
ode
> only for large-ish blobs.

=46WIW in JGit we control this by looking at the object size and
comparing to the variable core.streamFileThreshold. For any object
below this size we allocate the buffer, unpack into it, and return the
buffer to the caller. Only objects above the size use the streaming
code paths.

There is a performance difference, at least for us in Java. Most of
the overhead seems to be due to running zlib inflate() with a tiny
buffer size rather than the full destination buffer. This probably has
to do with the cost associated with jumping from the Java bytecode
through JNI to the libz library.

--=20
Shawn.
