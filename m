From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH 2/2] t/lib-http.sh: Enable httpd tests by default.
Date: Fri, 20 Nov 2009 11:03:13 -0800
Message-ID: <905315640911201103w6d1da86duf41a53537672be8e@mail.gmail.com>
References: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com> 
	<1258680123-28684-2-git-send-email-tarmigan+git@gmail.com> 
	<7vd43d7hdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, peff@peff.net, jaysoffian@gmail.com,
	drizzd@aon.at, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 20:03:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBYlf-0004GZ-9z
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 20:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbZKTTD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 14:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbZKTTD1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 14:03:27 -0500
Received: from mail-px0-f204.google.com ([209.85.216.204]:50707 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbZKTTD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 14:03:27 -0500
Received: by pxi42 with SMTP id 42so1962889pxi.5
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=b2c/uqVcISJk3kRFC0Ni7SsO+UbWH6Kjq2GZ7fu4S2c=;
        b=xIiSKMBemsEM9RQwwKz8ACMhTgy1JfF9ltr0qu/XMtaLjGNooraA27rP/AxgsyoQTt
         MFl73/PHgu0W3Hu6p9fAG+sgka2VEXqzsOB/j3xFX7tWv9WZtVNYo9IfiLpCKVLlwzOC
         z9alja/WzYggnf//YDQrQq8w4E66WTaCTdzXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=wNQodJjpIxBehOlJaS9oazKLBXxSH2NR4YUYeis8Uy+4qtXU7Eoe9zzTQSX6afOC8L
         e6wsZ4tneW+r3MCfzURkyi3n9vbT6hbp0DXmdRFRFSUSAbtYSmYRAQeYky637P0BVTEG
         nNNQmgfs9vCvU3afmzuG7/wVysR02mkHXmrO0=
Received: by 10.143.24.40 with SMTP id b40mr192106wfj.0.1258743813160; Fri, 20 
	Nov 2009 11:03:33 -0800 (PST)
In-Reply-To: <7vd43d7hdo.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: d42897ecbebec70e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133366>

On Fri, Nov 20, 2009 at 12:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Tarmigan <tarmigan+git@gmail.com> writes:
>
>> With smart http, git over http is likely to become much more common.
>> To increase testing of smart http, enable the http tests by default.
>
> Sorry, but no test that listens to network ports should be enabled by
> default; otherwise it will break automated, unattended tests people have
> already set up randomly, depending on when the port happens to be
> available for use by the tests.

Is this the only concern or are there security or other issues as well?

If that is the only concern, we could have the tests automatically
fall back to listening on a different port.  Even if we didn't, if
httpd cannot startup because it can't bind to the port, the http tests
say
* skipping test, web server setup failed
and exit with test_done before any of the tests actually fail.

Here's a patch (cut-n-paste so it will probably be munged) for
discussion of the port-fallback idea.  If httpd cannot bind to 5541,
it tries 15541 etc.  You can test this by running "nc -l 5541 &"
before the test.  If this approach might be acceptable, I can send a
properly formatted patch.

Comments?

Thanks,
Tarmigan

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 797a2d6..a8eb6fa 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -77,7 +77,7 @@ prepare_httpd() {

        if test -n "$LIB_HTTPD_SSL"
        then
-               HTTPD_URL=https://127.0.0.1:$LIB_HTTPD_PORT
+               HTTPD_URL=https://127.0.0.1

                RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
                        -config "$TEST_PATH/ssl.cnf" \
@@ -88,7 +88,7 @@ prepare_httpd() {
                export GIT_SSL_NO_VERIFY
                HTTPD_PARA="$HTTPD_PARA -DSSL"
        else
-               HTTPD_URL=http://127.0.0.1:$LIB_HTTPD_PORT
+               HTTPD_URL=http://127.0.0.1
        fi

        if test -n "$LIB_HTTPD_DAV" -o -n "$LIB_HTTPD_SVN"
@@ -109,16 +109,29 @@ start_httpd() {

        trap 'code=$?; stop_httpd; (exit $code); die' EXIT

-       "$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
-               -f "$TEST_PATH/apache.conf" $HTTPD_PARA \
-               -c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
-               >&3 2>&4
-       if test $? -ne 0
-       then
-               say "skipping test, web server setup failed"
-               trap 'die' EXIT
-               test_done
-       fi
+       while true
+       do
+               "$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
+                       -f "$TEST_PATH/apache.conf" $HTTPD_PARA \
+                       -c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
+                       >&3 2>&4
+               if test $? -ne 0
+               then
+                       if test $LIB_HTTPD_PORT -gt 40000
+                       then
+                               say "skipping test, web server setup failed"
+                               trap 'die' EXIT
+                               test_done
+                       fi
+                       LIB_HTTPD_PORT=$(($LIB_HTTPD_PORT + 10000))
+                       say "trying port $LIB_HTTPD_PORT"
+                       continue
+               else
+                       break
+               fi
+       done
+
+       HTTPD_URL="$HTTPD_URL:$LIB_HTTPD_PORT"
 }

 stop_httpd() {
