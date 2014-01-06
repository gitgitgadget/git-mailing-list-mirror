From: Stefan Zager <szager@google.com>
Subject: static initializers
Date: Mon, 6 Jan 2014 14:02:43 -0800
Message-ID: <CAHOQ7J8vQ-t1knSiWQ+RKv3QvwW2DZBy29DBhkxu7tEeXoJ-CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 06 23:02:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0IG3-0001Dp-5X
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 23:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbaAFWCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 17:02:46 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47851 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699AbaAFWCn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 17:02:43 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so18903232obc.21
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hcAGd2uHrrpdkqeWYygAhVYMhxSurNsMvp05aEYO+2w=;
        b=Cm2S0mTyoOCVwGBPBwgMxayXh1INdJgDc70ddqEwrfzTGmWGi56uF4bQUjf2ZDWfeJ
         5YCoOakbu4PhiGyU221dec0rOVOcxo7mSYvZW9aM6zbrTHV0lmXK+ZWwODlmdGvrjrCc
         twMksaflOk8qsaAoyd+S91uVe7BnEA35frQrGccFqVw6JmfB2kgeAVlI3UdxxNdXbPle
         wB0drJxDWHuV5Ewj5YspSDuptx7v4Mzyewi/PDexAwbIPrt9oNQpLZEhu05PGnm5Ypnj
         W8amz94Ixv7cLkOIGi2/oqYWBZ7yQI6Ox3sU1j9ZMwiXBLZOkwvTr3yXokxwZRFbtERy
         Cdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=hcAGd2uHrrpdkqeWYygAhVYMhxSurNsMvp05aEYO+2w=;
        b=Hxwf3tkWD2cjIyPXA6/FBQ92jiVvGK3C2P8bxG+Pum7W4isJ8hSxVFmHAUQHfl7CRX
         7DY9vS16X16QADQ3Hg10rHvoM0mRioKe0UB5rvyDTy8E/O5wYXFW8+l0Cyj2B8fAFTFk
         Nqthdp6Ornc1NKt0NFDoiy+y2qv8eEea/bSKkSqjizdsESvjUh9uNxSKC9YK7UI68xwq
         ZNjLqhEClFW2dENalqDWp14os+rkoB6Ga4UCNDEbSK8RRgUcc3UiHKyqQ5Fgb8rYXIJ2
         Rw/38yYYOvs0UqRaj7Zgi8O4enQy8ZSgoNEnOU9OgVm4oTmLzRoO8MI8PTziGnVmB2GH
         lN6g==
X-Gm-Message-State: ALoCoQlIwCYJlFhN51mCd+IXhWLHpHNNMd66+ktImwIjK9Uz5gXN2A8bhgt0a6KVHnR/k0UlmXlwKK5OIqUJRviO57DzyiaFs+63rHHqG32lzUpdSARDf861/jIuJVyQjvfRwhciAF5cNxnen5jHo6U0Hajvbs3G6Atvx2jqTfW76qtkEKjIIxR0q3rLAW4H5q50JYoop7oz
X-Received: by 10.182.29.66 with SMTP id i2mr74562642obh.23.1389045763277;
 Mon, 06 Jan 2014 14:02:43 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Mon, 6 Jan 2014 14:02:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240072>

Howdy,

Is there any policy on making static initializers thread-safe?  I'm
working on an experimental patch to introduce threading, but I'm
running into a few non-thread-safe bits like this, in convert.c:

static const char *conv_attr_name[] = {
    "crlf", "ident", "filter", "eol", "text",
};
#define NUM_CONV_ATTRS ARRAY_SIZE(conv_attr_name)

static void convert_attrs(struct conv_attrs *ca, const char *path)
{
    int i;
    static struct git_attr_check ccheck[NUM_CONV_ATTRS];

    if (!ccheck[0].attr) {
        for (i = 0; i < NUM_CONV_ATTRS; i++)
            ccheck[i].attr = git_attr(conv_attr_name[i]);
        user_convert_tail = &user_convert;
        git_config(read_convert_config, NULL);
    }
}



The easy fix would be to stick the initialization bit into an 'extern
int init_convert_config();' function, and invoke it prior to the
threaded part of my code.  That would be no worse than the current
state of affairs, which is to say that adding threading is rife with
hidden perils.

A more comprehensive fix might be:

#include <pthread.h>

static pthread_mutex_t convert_config_mutex = PTHREAD_MUTEX_INITIALIZER;

static void convert_attrs(struct conv_attrs *ca, const char *path)
{
    int i;
    static struct git_attr_check ccheck[NUM_CONV_ATTRS];

    pthread_mutex_lock(&convert_config_mutex);
    if (!ccheck[0].attr) {
        for (i = 0; i < NUM_CONV_ATTRS; i++)
            ccheck[i].attr = git_attr(conv_attr_name[i]);
        user_convert_tail = &user_convert;
        git_config(read_convert_config, NULL);
    }
    pthread_mutex_unlock(&convert_config_mutex);
}


Unfortunately, I don't think mingw/msys supports
PTHREAD_MUTEX_INITIALIZER.  A possible workaround would be:

static pthread_mutex_t convert_config_mutex;

static void init_convert_config_mutex() __attribute__((constructor));
static void init_convert_config_mutex()
{
    pthread_mutex_init(&convert_config_mutex);
}


But then, I'm not whether mingw/msys supports __attribute__(constructor).


Can anyone give me some guidance before I go to much further into the
weeds (and I'm neck-deep as it is)?

Thanks,

Stefan
