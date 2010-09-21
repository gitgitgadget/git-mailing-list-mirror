From: Christopher Wilson <cwilson@cdwilson.us>
Subject: Re: [PATCH] Enable highlight executable path as a configuration option
Date: Tue, 21 Sep 2010 00:25:19 -0700
Message-ID: <4C985DDF.8060807@cdwilson.us>
References: <4C96938C.5050505@cdwilson.us> <201009201110.38271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=22Alejandro_R=2E?= =?ISO-8859-1?Q?_Sede=F1o=22?= 
	<asedeno@mit.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 09:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxxEP-0001GC-Pv
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 09:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab0IUHZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 03:25:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56294 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab0IUHZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 03:25:31 -0400
Received: by pwi3 with SMTP id 3so1418892pwi.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 00:25:30 -0700 (PDT)
Received: by 10.114.123.9 with SMTP id v9mr11475546wac.116.1285053928644;
        Tue, 21 Sep 2010 00:25:28 -0700 (PDT)
Received: from [192.168.1.10] (c-67-170-193-75.hsd1.ca.comcast.net [67.170.193.75])
        by mx.google.com with ESMTPS id d2sm15001761wam.14.2010.09.21.00.25.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 00:25:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <201009201110.38271.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156694>

On 9/20/10 2:10 AM, Jakub Narebski wrote:
> On Mon, 20 Sep 2010, Christopher Wilson wrote:
> 
>> Allow build-time/run-time configuration of the highlight executable. Defaults
>> to previous behavior which assumes that highlight is available on the server
>> PATH. However, if this is not the case, the path to the highlight executable
>> can be configured at build time as a configuration variable
>>
>>      HIGHLIGHT_BIN = /path/to/highlight
>>
>> or at runtime by configuring GITWEB_CONFIG
>>
>>      $highlight_bin = /path/to/highlight
>>
>> Signed-off-by: Christopher Wilson<cwilson@cdwilson.us>
> 
> Good idea... but I am not sure about shell quoting and the problem
> with spaces in pathnames.  See comments below.
> 
>> ---
>>   gitweb/Makefile    |    4 +++-
>>   gitweb/README      |    7 ++++++-
>>   gitweb/gitweb.perl |    6 +++++-
>>   3 files changed, 14 insertions(+), 3 deletions(-)
> 
>> diff --git a/gitweb/README b/gitweb/README
>> index d481198..69f9860 100644
>> --- a/gitweb/README
>> +++ b/gitweb/README
>> @@ -114,6 +114,9 @@ You can specify the following configuration variables when building GIT:
>>      when gitweb.cgi is executed, then the file specified in the environment
>>      variable will be loaded instead of the file specified when gitweb.cgi was
>>      created.  [Default: /etc/gitweb.conf]
>> + * HIGHLIGHT_BIN
>> +   Path to the highlight executable to use. Useful if highlight is not
>> +   installed on your webserver's PATH. [Default: highlight]
> 
> I think it needs to be said that this 'highlight' executable must be
> the one from http://www.andre-simon.de (assumptions about parameters and
> output).
> 
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index a85e2f6..e808485 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
> [...]
>> @@ -3360,7 +3364,7 @@ sub run_highlighter {
>>   	close $fd
>>   		or die_error(404, "Reading blob failed");
>>   	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>> -	          "highlight --xhtml --fragment --syntax $syntax |"
>> +	          "$highlight_bin --xhtml --fragment --syntax $syntax |"
> 
> I think you need
> 
>    +	          quote_command($highlight_bin)." --xhtml --fragment --syntax $syntax |"
> 
> here
> 
>>   		or die_error(500, "Couldn't open file or run syntax highlighter");
>>   	return $fd;
>>   }
>> -- 
>> 1.7.2.3
>>
>>
> 

Jakub, thanks for the helpful feedback.  I included the updated patch (see below) which includes the changes you suggested.

Allow build-time/run-time configuration of the highlight executable
(must be the one from http://www.andre-simon.de due to assumptions
about parameters and output).  Defaults to previous behavior which
assumes that highlight is available on the server PATH. However, if
this is not the case, the path to the highlight executable can be
configured at build time as a configuration variable

    HIGHLIGHT_BIN = /path/to/highlight

or at runtime by configuring GITWEB_CONFIG

    $highlight_bin = /path/to/highlight

Signed-off-by: Christopher Wilson <cwilson@cdwilson.us>
---
 gitweb/Makefile    |    4 +++-
 gitweb/README      |   11 ++++++++++-
 gitweb/gitweb.perl |    9 ++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 gitweb/README

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 2fb7c2d..e32ee76 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -35,6 +35,7 @@ GITWEB_FAVICON = static/git-favicon.png
 GITWEB_JS = static/gitweb.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
+HIGHLIGHT_BIN = highlight
 
 # include user config
 -include ../config.mak.autogen
@@ -129,7 +130,8 @@ GITWEB_REPLACE = \
 	-e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
 	-e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
 	-e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
-	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g'
+	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
+	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g'
 
 GITWEB-BUILD-OPTIONS: FORCE
 	@rm -f $@+
diff --git a/gitweb/README b/gitweb/README
old mode 100644
new mode 100755
index d481198..bf3664f
--- a/gitweb/README
+++ b/gitweb/README
@@ -114,6 +114,11 @@ You can specify the following configuration variables when building GIT:
    when gitweb.cgi is executed, then the file specified in the environment
    variable will be loaded instead of the file specified when gitweb.cgi was
    created.  [Default: /etc/gitweb.conf]
+ * HIGHLIGHT_BIN
+   Path to the highlight executable to use (must be the one from
+   http://www.andre-simon.de due to assumptions about parameters and output).
+   Useful if highlight is not installed on your webserver's PATH.
+   [Default: highlight]
 
 
 Runtime gitweb configuration
@@ -236,7 +241,11 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavailable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
-
+ * $highlight_bin
+   Path to the highlight executable to use (must be the one from
+   http://www.andre-simon.de due to assumptions about parameters and output).
+   Useful if highlight is not installed on your webserver's PATH.
+   [Default: highlight]
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..e5910ce 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -165,6 +165,12 @@ our @diff_opts = ('-M'); # taken from git_commit
 # the gitweb domain.
 our $prevent_xss = 0;
 
+# Path to the highlight executable to use (must be the one from
+# http://www.andre-simon.de due to assumptions about parameters and output).
+# Useful if highlight is not installed on your webserver's PATH.
+# [Default: highlight]
+our $highlight_bin = "++HIGHLIGHT_BIN++";
+
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats = (
 	# name => {
@@ -3360,7 +3366,8 @@ sub run_highlighter {
 	close $fd
 		or die_error(404, "Reading blob failed");
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
-	          "highlight --xhtml --fragment --syntax $syntax |"
+	          quote_command($highlight_bin).
+	          " --xhtml --fragment --syntax $syntax |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
 	return $fd;
 }
-- 
1.7.2.3
