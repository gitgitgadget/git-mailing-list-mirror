From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 2/3] A simple python script to parse the results from the testcases
Date: Mon, 12 May 2008 11:33:51 +0200
Message-ID: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
Cc: dsymonds@gmail.com, Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 12:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvUq7-0004Gn-Lk
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 12:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725AbYELKAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 06:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757801AbYELKAK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 06:00:10 -0400
Received: from olive.qinip.net ([62.100.30.40]:51901 "EHLO olive.qinip.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757648AbYELKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 06:00:07 -0400
Received: from localhost.localdomain (h8922088209.dsl.speedlinq.nl [89.220.88.209])
	by olive.qinip.net (Postfix) with ESMTP id CABD7FB66;
	Mon, 12 May 2008 11:33:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81846>

This is a simple script that aggregates key:value pairs in a file.
I am sure this can be done better with a 'grep | sed | awk' combination,
my skills with awk / your program of choice is not as profound.
This script serves more as a demonstration on how to use the testcase output.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 t/key_value_parser.py |   78 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100755 t/key_value_parser.py

diff --git a/t/key_value_parser.py b/t/key_value_parser.py
new file mode 100755
index 0000000..e172df1
--- /dev/null
+++ b/t/key_value_parser.py
@@ -0,0 +1,78 @@
+#!/usr/bin/env python
+
+"""Module for parsing files with 'key value' pairs.
+
+Usage summary: key_value_parser.py "path/to/file"
+"""
+
+def parseFile(path):
+	"""Parses a file containing pair value couples.
+	
+	The values are expected to be integers.
+	If more than one value for a pair is found, these values are aggregated.
+	The size of the longest key is stored in '__maxsize'.
+	A dictionairy with only '__maxsize:0' is returned if an error occured.
+	"""
+
+	dict = {"__maxsize" : 0}
+
+	try:
+		file = open(path)
+		for line in file:
+			if line == '\n':
+				continue
+
+			pos = line.index(' ')
+			key = line[:pos]
+			
+			# Skip the space and the trailing newline
+			value = line[pos+1:-1] 
+			intvalue = int(value)
+
+			if key in dict:
+				dict[key] = intvalue + dict[key]
+			else:
+				dict[key] = intvalue
+
+			if len(key) > dict["__maxsize"]:
+				dict["__maxsize"] = len(key)
+
+	except IOError:
+		print("Cannot open or read from file " + path)
+	except ValueError:
+		print("Malformed line in file ")
+
+	return dict
+
+def main(argv):
+	""" Invokes parseFile on the path specified as argument.
+	
+	If no argument is specified, a default of 
+	'/tmp/git-test-results' is used.
+
+	The resulting dictionary is printed, ignoring keys starting with '__'.
+	All output is left justified to the size of the largest key.
+	"""
+	path = "/tmp/git-test-results"
+	
+	# If a path was specified as argument, use that
+	if len(argv) > 1:
+		path = argv[1]
+
+	# Parse the file
+	dict = parseFile(path)
+
+	# Retreive the max size and add one space for readability
+	maxsize = dict["__maxsize"] + 1
+
+	# Print the result
+	for key,value in dict.iteritems():
+		# Don't print meta-data
+		if key.startswith("__"):
+			continue
+
+		print(key.ljust(maxsize) + str(value))
+
+if __name__ == '__main__':
+	import sys
+	main(sys.argv)
-- 
1.5.5.1.178.g1f811
