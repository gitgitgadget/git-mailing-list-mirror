From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/12] vcs-svn: use higher mark numbers for blobs
Date: Wed, 9 Mar 2011 00:55:28 -0600
Message-ID: <20110309065528.GA28098@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
 <20110306230348.GC24327@elie>
 <7vzkp5e8gr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 07:55:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxDJC-0001jd-6l
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 07:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab1CIGzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 01:55:40 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46124 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1CIGzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 01:55:39 -0500
Received: by yia27 with SMTP id 27so91521yia.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Te564BDITbWU268xNtAYmtDeNPzZXk/PpBpAxGd/r4c=;
        b=L3pydYqIUP4oXaWvB/LSqVzaFLAI+TK6/DxgAQZYizT+YzwZyhH47vV+GDJLQqTlaB
         U6X8TG3/ddXYhn9GtDcCCwfQCPTGZN5EHstH8HJ8Xzd6sZxvmk4NZaez6xvj3L2T/ZJS
         hhhzupx7CUWtvpYRStflKawQ3MZ9RkZojIpc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QmwbDSfo2VpzbouyUfh2JgbLX6dj95K6UsKj7oWsbZyPX2yj8JMpeFoomGHNsCIfA9
         XlR7SnldatWu3IQ3Pc4PjogpDFcIbtBuvarexw7ccH12KBctcR1q/doaUXtYEzm4ZHEw
         bdklHYgKioJWdIiFzgUCh/zY78qlLNHUcpYG8=
Received: by 10.150.60.17 with SMTP id i17mr1936726yba.50.1299653739179;
        Tue, 08 Mar 2011 22:55:39 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.sbcglobal.net [69.209.61.99])
        by mx.google.com with ESMTPS id q18sm3104350ybk.23.2011.03.08.22.55.35
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 22:55:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzkp5e8gr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168720>

Hi,

Junio C Hamano wrote:

> Hmm, 1G+3G split?  Will we have HIGHMEM option someday? ;-)
>
> How confident are you that you will never need more than two classes later
> and you will never need to split the larger space again?
>
> If you are not, and if the topic is to introduce incompatible output,
> would it be wiser to be even more forward looking and introduce different
> classes of marks with a backward incompatible syntax, perhaps like using
> ":\d+" for anything, and using ":[a-zA-Z0-9]+:\d+" for some application
> specific "class" of objects that is specifed by the [a-zA-Z0-9]+ part?

That sounds very sensible (and I'd be happy to see something like
that).

In this particular case a later patch ("vcs-svn: eliminate repo_tree
structure") gets rid of the blob marks so the split is temporary.
Perhaps a paragraph added to the change description would clear it up.

	A later patch will eliminate the blob marks altogether.

For the "vcs-svn: eliminate repo_tree" patch:

	Rely on fast-import for information about previous revs.

	This requires always setting up backward flow of information,
	even for v2 dumps.  On the plus side:

	 - No more need to include blobs in the marks table.
	 - Given one dump that picks up where another left off, svn-fe
	   can continue the import.  Use

		git fast-import --relative-marks \
			--export-marks=svn-revs \
			--cat-blob-fd=3 3>backchannel

	   for the first import and

		git fast-import --relative-marks \
			--import-marks=svn-revs \
			--export-marks=svn-revs \
			--cat-blob-fd=3 3>backchannel

	   for later ones.
	 - It simplifies the code by quite a bit and opens the door
	   to further simplifications.

Thanks for some clarity.
Jonathan
