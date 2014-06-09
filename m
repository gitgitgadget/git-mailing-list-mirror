From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH/RFC v1 0/5] add strbuf_set operations
Date: Mon, 9 Jun 2014 15:06:41 -0700
Message-ID: <20140609220641.GC18783@hudson.localdomain>
References: <cover.1402301815.git.jmmahler@gmail.com>
 <CACsJy8D_eM9OtH=6Z_F0P7GZpqmAdSCEnBjCr_gniZr649P1uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:06:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7iN-0007af-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbaFIWGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:06:48 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:44154 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbaFIWGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:06:46 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so5361916pdj.34
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xAMnj8x3RvfHFLjuDJfvaHI5cIFeklDr7YE5RS8Ug0o=;
        b=nhBOk+DM9LJO8DBdg2OOvuzFvkNYjcTpVV+YzJq3EhW/Ey6tMOVym3irjHL7yriub9
         re/bPU1jJ5Ske7Fi8j0WyfXQjsgs9dyVIPVTChZWxwwIuQwCSYYcAS47PhHXx/nt2KbS
         2A0nQgsoD+G40CbBj2AfgYWtqUEJW4Wvhc7bG3f20VMP4zFJ+i9bWtsDgPIhpXbg8L1V
         UmvqX4xic36mQuinQx7Xoq2neRoGTItZZDH13JsZIleV2vw3YAwNAnYD3byQS1YAdAsR
         90ZvE6fLMb3ZenmLDHjPBneyHicnn90kyX7K6VmxKHDc6IKXjrpFyALY1/l8p41l+B7Z
         VhYw==
X-Received: by 10.68.106.130 with SMTP id gu2mr7319692pbb.59.1402351606376;
        Mon, 09 Jun 2014 15:06:46 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id tf10sm65745714pbc.70.2014.06.09.15.06.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:06:45 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:06:41 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CACsJy8D_eM9OtH=6Z_F0P7GZpqmAdSCEnBjCr_gniZr649P1uw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251106>

Duy,

On Mon, Jun 09, 2014 at 05:39:12PM +0700, Duy Nguyen wrote:
> On Mon, Jun 9, 2014 at 3:36 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> > Currently, the data in a strbuf is modified using add operations.  To
> > set the buffer to some data a reset must be performed before an add.
> >
> >   strbuf_reset(buf);
> >   strbuf_add(buf, cb.buf.buf, cb.buf.len);
> >
> > And this is a common sequence of operations with 70 occurrences found in
> > the current source code.  This includes all the different variations
> > (add, addf, addstr, addbuf, addch).
> >
> >   FILES=`find ./ -name '*.c'`
> >   CNT=$(pcregrep -M "strbuf_reset.*\n.*strbuf_add" $FILES | wc -l)
> 
> Hmm.. I wonder if git-grep could do this.. There's pcre support but I
> never tried.
> 
Not sure if git-grep does this.  The multi-line (-M) support was the
thing I needed.

> >   CNT=$(echo "$CNT / 2" | bc)
> >   echo $CNT
> >   70
> 
> The change in this series looks nice. There's another pattern, save
> strbuf length, then strbuf_setlen() at the beginning or the end of a
> loop. But I think it's less often.

A quick look did not see any obvious patterns for this.  I think you are
right, there may be fewer cases.

> -- 
> Duy

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
