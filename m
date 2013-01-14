From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/14] imap-send.c: use struct imap_store instead of
 struct store
Date: Sun, 13 Jan 2013 22:52:27 -0800
Message-ID: <20130114065227.GJ3125@elie.Belkin>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
 <1358141566-26081-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:52:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuduh-0007Zl-CZ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 07:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab3ANGwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 01:52:33 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51751 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab3ANGwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 01:52:32 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so2068505pad.36
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 22:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HfaQprWkgYEOuNLdZDmjhuOimywDMviSHBraWmMd6z0=;
        b=FAub9sFCuBNIcanniGu7+wEvwukDg2bLbd6L0pWG5jxaxqVBHoGymn36jYpVFCnJa2
         lJ3fkKChcdRH7x9m1nWGoSuG1Xa2zkYaEG4bEYKeQyPm95qIeraUcCb+mOi+D8DA2nfV
         x5CbsoGOeth9Ya2SiTGaqZXugMxgFfMkre1I3OFVzQ0DroywO1+nrcVuW2ajSvf1i2RZ
         zB/bh/2pSeLT32qB6vjT2KwbV1SJhIxLRa0jaye0/JD3VqzNPKNbF/ED2irMBMTiuvUb
         01QjwAPOFBIZkzJGfR2qvrDq0m0sV/E7J+sE30klxABXgbRpUtiijy6o157uYG/MIYVJ
         kVxQ==
X-Received: by 10.68.143.162 with SMTP id sf2mr251143042pbb.137.1358146351895;
        Sun, 13 Jan 2013 22:52:31 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id na7sm7673314pbc.48.2013.01.13.22.52.29
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 22:52:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358141566-26081-13-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213455>

Michael Haggerty wrote:

> In fact, all struct store instances are upcasts of struct imap_store
> anyway, so stop making the distinction.

Nice.

It is tempting to fold "struct store" into "struct imap_store" at the same
time, as in

	struct imap_store {
		struct {
			struct store_conf *conf; /* foreign */

			/* currently open mailbox */
			const char *name; /* foreign! maybe preset? */
			char *path; /* own */
			struct message *msgs; /* own */
			int uidvalidity;
			unsigned char opts; /* maybe preset? */
			/* note that the following do _not_ reflect stats from msgs, but mailbox totals */
			int count; /* # of messages */
			int recent; /* # of recent messages - don't trust this beyond the initial read */
		} gen;
		int uidvalidity;
		struct imap *imap;
		const char *prefix;
		unsigned /*currentnc:1,*/ trashnc:1;
	};

to help the reader verify that objects of type "struct store" are not
used except through the gen field of imap_store after this change.
But verifying directly worked fine, so never mind. ;-)
