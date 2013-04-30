From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: [PATCH 1/5] git-svn: fix occasional "Failed to strip path" error on fetch next commit, try #3
Date: Wed, 1 May 2013 00:10:28 +0400
Message-ID: <1285665433.20130501001028@gmail.com>
References: <5180046b.6905700a.65c8.00b4@mx.google.com> <7vobcvdec2.fsf@alter.siamese.dyndns.org>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGuN-0001cw-Av
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058Ab3D3UML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:12:11 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:61732 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761164Ab3D3UMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:12:10 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so790519lab.22
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=dzxTDQxvXtKs4ulX1qd62OGMD20sxIfFjQKuSD1vDTE=;
        b=V7s1bLxZ4ed0JoancD6rF+43RlMu/WCSE+EnoGrh9N/ircMyFVy+PpOnwmLgLftocG
         lID5Hsd2LppTlP6Pun/lWOAfw3KY9SHUJ/IY47fb9atSwF6lH7wDl20UlVsn+OyrmFtd
         aQ/4ns05H2kxHzxfAk+G/Frthvgs+i2XcOIPZb/PXVgCXDnl47LkEwMmiCl9iptjZy3y
         VOOu4uogrgxQ/jLsgSYfLhqi9CYBgKF181j1YPQU15YY07HcHeDvTFZz5IN5jIF/6vlf
         y5Wtr+9m4URaRGYNj0QZkPHPkS62fVQl7uarakSczRX0GXFFeF++XpbSGW03q0hBsqCR
         3j6Q==
X-Received: by 10.152.4.131 with SMTP id k3mr30186645lak.26.1367352727115;
        Tue, 30 Apr 2013 13:12:07 -0700 (PDT)
Received: from [192.168.0.78] ([178.71.111.32])
        by mx.google.com with ESMTPSA id t17sm170600lbd.11.2013.04.30.13.12.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 13:12:06 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <7vobcvdec2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223002>

>>  }
>>  
>> @@ -458,9 +459,12 @@ sub find_empty_directories {
>>               my $skip_added = 0;
>>               foreach my $t (qw/dir_prop file_prop/) {
>>                       foreach my $path (keys %{ $self->{$t} }) {
>> -                             if (exists $self->{$t}->{dirname($path)}) {
>> -                                     $skip_added = 1;
>> -                                     last;
>> +                             if (length $self->git_path($path)) {
>> +                                     $path = dirname($path);
>> +                                     if ($dir eq $self->git_path($path) && exists $self->{$t}->{$path}) {
>> +                                             $skip_added = 1;
>> +                                             last;
>> +                                     }

JCH> I am reading that this is a solution for your second issue (use
JCH> git_path() to convert $path).  An empty $path would be a top-level
JCH> and skipping it corresponds to the "next if $dir eq '.'" at the
JCH> beginning of the loop, I guess.

JCH> When "$dir ne $self->git_path(dirname($path))", what should happen?

'ls-tree' will be executed.
I guess, the original idea was to save processes, although I don't
know why the dir is in @deleted_gpath, if it has children.
