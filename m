From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2 properly indented] fix start_command() bug when stdin
 is closed
Date: Tue, 26 Aug 2008 08:45:13 +0200
Message-ID: <48B3A679.2050103@gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <E1KXcH3-0000zJ-0m@fencepost.gnu.org> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 08:46:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXsJr-0001lu-2G
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 08:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbYHZGpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 02:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYHZGpS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 02:45:18 -0400
Received: from qb-out-0506.google.com ([72.14.204.237]:3487 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbYHZGpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 02:45:17 -0400
Received: by qb-out-0506.google.com with SMTP id a16so3068153qbd.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=oeWd+SFJinU2P4dJmt1Dx1gghIeFoTe+9S44BRLulsk=;
        b=UuoFJlLgN4DEpiVmugfG0y/TjVy6ryQfYTMQo/NS5MX2k4PUjmaMkPx7pSj9ZVPgrP
         i6kzDhG+EL9tG/Yr7CL2x3CAg01q7y9zX9TRHNLp6H+WZHMBotgUvvE41N9+SkaPwY/Q
         z3LPDqOHlCpVcsBHxZL505C18ZnCSqKDC6CF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=Ul0fHYDcdoUsegyyrpVFTZ5OdfpHw3lQDBFG7MUxf9O7LVu/36lZRojOv/z9STjTOo
         H/krrfr0Ts0r6t9z6E2jUUrfReTPWMJGqQbk/8mP2d61gxzwVrEXJq1sddT7R2iizPfz
         CTTVRFUv7WMrkL5TtyQxkX7SYEVZWzrzoxlJA=
Received: by 10.86.31.18 with SMTP id e18mr4034891fge.52.1219733115779;
        Mon, 25 Aug 2008 23:45:15 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e20sm5646785fga.1.2008.08.25.23.45.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 23:45:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93716>

Hannes already answered everything, but now that I think more about it I
would actually consider putting it in main, just in case an important
file ends up in file descriptor = 2 and is corrupted by a call to die().
 Just in case, this program shows that stderr always point to fd 2 even
if it is closed upon launch:

  #include <stdio.h>
  #include <fcntl.h>

  int main()
  {
    int fd = open ("/dev/tty", O_WRONLY);
    FILE *fp;
    fp = fdopen (fd, "w");
    fprintf (fp, "file descriptor %d\n", fd);
    fflush (fp);
    fprintf (stderr, "writing on stderr now\n");
  }

  bonzinip$ ./a.out 2<&-
  file descriptor 2
  writing on stderr now
  bonzinip$

Patch coming in a moment.

Paolo
