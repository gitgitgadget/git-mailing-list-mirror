From: "Robert Newson" <robert.newson@gmail.com>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 16:31:39 +0100
Message-ID: <46aeb24f0708310831n3c16dbbeke173b6f0cdfa7792@mail.gmail.com>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	 <7vveav21uv.fsf@gitster.siamese.dyndns.org>
	 <20070831152153.GA30745@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:32:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR8TP-0002TT-TA
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 17:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbXHaPbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 11:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756852AbXHaPbl
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 11:31:41 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:41069 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638AbXHaPbk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 11:31:40 -0400
Received: by rv-out-0910.google.com with SMTP id k20so444261rvb
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 08:31:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dXus0uW+PNAHY+TFRoDsqPvRXU2+kWWZYxU+WQj+No0maDSnTKUgAZoiNGLmwpTijwtAxjn5apFW4BJ5Fy/Ds40UecwN0LaX6TRN/jsVGamEyv9rTVKwLYzhkq/lvOmXfuWx59GTo/u/RhWUzNAdqLj64WhQF607opylYI14/CU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fdjtZgbhJeQ3fnNT9rDmpQQcWbUxIiD9YB4eH+i3rA/mttEPXRN3dplNCOhNPulbI971lGdDmbsshIVzpnDRmfxcrcCUAfIlY9HyJm4hITrFYSY1HHhEXkfj7QX/kwQFBG8VNr3i6FTIoNnsSJ4puecydANTCAmnW1ItFeVylls=
Received: by 10.115.89.1 with SMTP id r1mr1591914wal.1188574299432;
        Fri, 31 Aug 2007 08:31:39 -0700 (PDT)
Received: by 10.115.19.3 with HTTP; Fri, 31 Aug 2007 08:31:39 -0700 (PDT)
In-Reply-To: <20070831152153.GA30745@muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57174>

The difference between the version I'm using (1.5.2.4) and this broken
version shows us what's happened. The $hash value was initialised in
the loop, and now it isn't.

Running 'git-svn log' in my git-svn'ed repo shows this up every time,
it's easy to reproduce.

        my ($head, $refs) = @_;
-       my ($fh, $ctx) = command_output_pipe('rev-list', $head);
-       while (my $hash = <$fh>) {
-               chomp($hash);
-               my ($url, $rev, $uuid) = cmt_metadata($hash);
+       my ($fh, $ctx) = command_output_pipe('log', $head);
+       my $hash = "";
+       my %max;
+       while (<$fh>) {
+               if ( m{^commit ($::sha1)$} ) {
+                       unshift @$refs, $hash if $hash and $refs;
+                       $hash = $1;
+                       next;
+               }
