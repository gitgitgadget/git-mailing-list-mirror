From: "Tim Stewart" <tim.j.stewart@gmail.com>
Subject: memory inefficiency in builtin-commit-tree.c - add_buffer() - in git version 1.5.2
Date: Thu, 12 Jul 2007 10:35:13 -0600
Message-ID: <23f4d5c70707120935k7a784f59rb3bb27ac76cb52b7@mail.gmail.com>
References: <23f4d5c70707120933l1d1664adgd12042a35f4629cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 18:35:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I91dT-00024L-Ey
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 18:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbXGLQfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 12:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765927AbXGLQfR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 12:35:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:42304 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765172AbXGLQfP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 12:35:15 -0400
Received: by wr-out-0506.google.com with SMTP id i30so147197wra
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 09:35:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bsSRo8UrG/5XFmhGA9UbkDvlQQ0Q4847HnS/1kN40mwqyLNkCJOxvp1lCD+nVWgbRbulmuhVc7xlQlOV7itVgyOSnki+GVnsk6tu4O/yXRD6qnvYcJtCi/oandUkDBYKGGhuJkUwkF7HKKX1Kyagx65frdsWLLcXypT+FOrxr1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VMeMa0uQs/XG59o1dzNFAYxWAZjTJ2/pZYhFN+RRFu1exjuMXmtJAiONqGIiJ+hAu17Qhl88UkpFELsm4mAkmL5ot3ZmL6MFyd4V+LnjQNiG30CuZHfRyYHITv4dMXvgUli9aRhh9h4G1xDijbBuRfRd/P8sUrFANF1PgjMqUME=
Received: by 10.142.100.1 with SMTP id x1mr59773wfb.1184258114030;
        Thu, 12 Jul 2007 09:35:14 -0700 (PDT)
Received: by 10.142.100.21 with HTTP; Thu, 12 Jul 2007 09:35:13 -0700 (PDT)
In-Reply-To: <23f4d5c70707120933l1d1664adgd12042a35f4629cd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52303>

The function init_buffer allocates 16,384 bytes.  This function then
sets the size of the buffer at 0 bytes.

Then when add_buffer is called, it calculates how much memory the
added bytes will take up here:

        alloc = (size + 32767) & ~32767;

Since size is 0, alloc will be 0.  So the next line:

         if (newsize > alloc) {

will always evaluate to true (unless newsize is 0) and then the
function reallocs the buffer at twice it's current size.

This all but guarantees that the memory allocated in init_buffer will
be realloc'ed.

Here is the code for your reference:

static void init_buffer(char **bufp, unsigned int *sizep)
{
        *bufp = xmalloc(BLOCKING);
        *sizep = 0;
}

static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
{
        char one_line[2048];
        va_list args;
        int len;
        unsigned long alloc, size, newsize;
        char *buf;

        va_start(args, fmt);
        len = vsnprintf(one_line, sizeof(one_line), fmt, args);
        va_end(args);
        size = *sizep;
        newsize = size + len + 1;
        alloc = (size + 32767) & ~32767;
        buf = *bufp;
        if (newsize > alloc) {
                alloc = (newsize + 32767) & ~32767;
                buf = xrealloc(buf, alloc);
                *bufp = buf;
        }
        *sizep = newsize - 1;
        memcpy(buf + size, one_line, len);
}
