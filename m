From: imyousuf@gmail.com
Subject: [JGit-io-RFC-PATCH v2 1/4] Introduce a new module for IO SPI of JGit
Date: Sun, 11 Oct 2009 21:07:50 +0700
Message-ID: <1255270073-14205-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 16:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwz7j-0008An-Cx
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 16:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbZJKOIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 10:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbZJKOIu
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 10:08:50 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:55821 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbZJKOIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 10:08:48 -0400
Received: by ewy4 with SMTP id 4so1831311ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cehSIfhyaWcxUJOAmo5MlcN9vvqiPEm+OoKDI6GFjp4=;
        b=m7qRnmpWottGEAyD7NexGPl44i5iEgs6DKP2sVGeawBCf/OzIX8OmAZFB9pXoZibTx
         DRRPlXMrddqD8GlHMWBT+yGjc46Zi1Y25evp0fDxQDyTOCJFAAPQVh6fy2nr3CTt5uEt
         f072Lf5jF+NY7dqCZI/QJk5eK/q9MBEGX4gro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mJoULBlB9/VMGXEQdeI7XWLOCf0lfX/GWEAyGFjnvfrcwEhgdRp0duRiM3bS349ziH
         NJWjW4Z4maErxNJvAsBFIV5QqQZtv6Zo6FrKAa39XYpIfQ84qUV4Cwb7/lTSCQILku0Q
         NU+7Do1RKxqAExpOODJKHB/9Yi8j5r6jOfnIU=
Received: by 10.211.143.19 with SMTP id v19mr2819039ebn.47.1255270091143;
        Sun, 11 Oct 2009 07:08:11 -0700 (PDT)
Received: from localhost.localdomain ([119.30.36.8])
        by mx.google.com with ESMTPS id 23sm2698205eya.42.2009.10.11.07.08.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 07:08:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129927>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

The reason for having a separate module is quite obvious, the IO SPI
providers need not have to depend on the whole JGit but rather only on
the SPI itself. As of the initial implementation the SPI will also contain
the default implementation - local file system provider.

Extract maven POM file to a common file to encapsulate the common setting
and configuration to be used across all maven modules for JGit.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 jgit-maven/jgit-io/pom.xml    |   65 +++++++++
 jgit-maven/jgit/pom.xml       |  287 ++++++++++-------------------------------
 jgit-maven/{jgit => }/pom.xml |   31 +----
 3 files changed, 143 insertions(+), 240 deletions(-)
 create mode 100644 jgit-maven/jgit-io/pom.xml
 rewrite jgit-maven/jgit/pom.xml (68%)
 rename jgit-maven/{jgit => }/pom.xml (90%)

diff --git a/jgit-maven/jgit-io/pom.xml b/jgit-maven/jgit-io/pom.xml
new file mode 100644
index 0000000..f197f58
--- /dev/null
+++ b/jgit-maven/jgit-io/pom.xml
@@ -0,0 +1,65 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!--
+All rights reserved.
+Redistribution and use in source and binary forms, with or
+without modification, are permitted provided that the following
+conditions are met:
+
+Redistributions of source code must retain the above copyright
+notice, this list of conditions and the following disclaimer.
+
+Redistributions in binary form must reproduce the above
+copyright notice, this list of conditions and the following
+disclaimer in the documentation and/or other materials provided
+with the distribution.
+
+Neither the name of the Eclipse Foundation, Inc. nor the
+names of its contributors may be used to endorse or promote
+products derived from this software without specific prior
+written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+-->
+<project xmlns="http://maven.apache.org/POM/4.0.0"
+        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+    <modelVersion>4.0.0</modelVersion>
+    <parent>
+        <groupId>org.eclipse</groupId>
+        <artifactId>jgit-parent</artifactId>
+        <version>0.6.0-SNAPSHOT</version>
+    </parent>
+    <groupId>org.eclipse</groupId>
+    <artifactId>jgit-io</artifactId>
+    <packaging>jar</packaging>
+    <name>jgit-io</name>
+    <build>
+        <sourceDirectory>../../org.eclipse.jgit.io/src/</sourceDirectory>
+        <testResources>
+            <testResource>
+                <directory>../../org.eclipse.jgit.test/tst-rsrc/</directory>
+            </testResource>
+        </testResources>
+        <testSourceDirectory>../../org.eclipse.jgit.io/tst/</testSourceDirectory>
+    </build>
+    <dependencies>
+        <dependency>
+            <groupId>junit</groupId>
+            <artifactId>junit</artifactId>
+            <version>3.8.1</version>
+            <scope>test</scope>
+        </dependency>
+    </dependencies>
+</project>
diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
dissimilarity index 68%
index d8772ad..9eb5758 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -1,216 +1,71 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<!--
-All rights reserved.
-Redistribution and use in source and binary forms, with or
-without modification, are permitted provided that the following
-conditions are met:
-
-Redistributions of source code must retain the above copyright
-notice, this list of conditions and the following disclaimer.
-
-Redistributions in binary form must reproduce the above
-copyright notice, this list of conditions and the following
-disclaimer in the documentation and/or other materials provided
-with the distribution.
-
-Neither the name of the Eclipse Foundation, Inc. nor the
-names of its contributors may be used to endorse or promote
-products derived from this software without specific prior
-written permission.
-
-THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
-CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
-INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
-OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
-CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
-NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
-CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
-STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
-ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--->
-<project xmlns="http://maven.apache.org/POM/4.0.0"
-        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
-    <modelVersion>4.0.0</modelVersion>
-    <groupId>org.eclipse</groupId>
-    <artifactId>jgit</artifactId>
-    <packaging>jar</packaging>
-    <version>0.6.0-SNAPSHOT</version>
-    <name>jgit</name>
-    <url>http://repo.or.cz/w/jgit.git</url>
-    <mailingLists>
-        <mailingList>
-            <name>GIT Mailing List</name>
-            <post>git@vger.kernel.org</post>
-            <archive>http://marc.info/?l=git</archive>
-        </mailingList>
-    </mailingLists>
-    <description>Pure Java implementation of Git</description>
-    <developers>
-        <developer>
-            <name>Shawn O. Pearce</name>
-            <email>spearce@spearce.org</email>
-            <roles>
-                <role>Maintainer</role>
-            </roles>
-        </developer>
-        <developer>
-            <name>Robin Rosenberg</name>
-            <email>robin.rosenberg@dewire.com</email>
-            <roles>
-                <role>Maintainer</role>
-            </roles>
-        </developer>
-        <developer>
-            <name>Dave Watson</name>
-            <email>dwatson@mimvista.com</email>
-            <roles>
-                <role>Developer</role>
-            </roles>
-        </developer>
-        <developer>
-            <name>Roger C. Soares</name>
-            <email>rogersoares@intelinet.com.br</email>
-            <roles>
-                <role>Developer</role>
-            </roles>
-	</developer>
-	<developer>
-            <name>Marek Zawirski</name>
-            <email>marek.zawirski@gmail.com</email>
-            <roles>
-                <role>Developer</role>
-            </roles>
-        </developer>
-        <developer>
-            <name>Charles O'Farrell</name>
-            <email>charleso@charleso.org</email>
-            <roles>
-                <role>Contributor</role>
-            </roles>
-        </developer>
-        <developer>
-            <name>Imran M Yousuf</name>
-            <email>imyousuf@smartitengineering.com</email>
-            <organization>Smart IT Engineering</organization>
-            <roles>
-                <role>Contributor</role>
-            </roles>
-        </developer>
-    </developers>
-    <licenses>
-        <license>
-            <name>Eclipse Distribution License (New BSD License)</name>
-            <comments>
-                All rights reserved.
-                Redistribution and use in source and binary forms, with or
-                without modification, are permitted provided that the following
-                conditions are met:
-
-                Redistributions of source code must retain the above copyright
-                notice, this list of conditions and the following disclaimer.
-
-                Redistributions in binary form must reproduce the above
-                copyright notice, this list of conditions and the following
-                disclaimer in the documentation and/or other materials provided
-                with the distribution.
-
-                Neither the name of the Eclipse Foundation, Inc. nor the
-                names of its contributors may be used to endorse or promote
-                products derived from this software without specific prior
-                written permission.
-
-                THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
-                CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
-                INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
-                OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-                ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
-                CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-                SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
-                NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-                LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
-                CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
-                STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-                ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
-                ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-            </comments>
-        </license>
-    </licenses>
-    <build>
-        <sourceDirectory>../../org.eclipse.jgit/src/</sourceDirectory>
-        <testResources>
-            <testResource>
-                <directory>../../org.eclipse.jgit.test/tst-rsrc/</directory>
-            </testResource>
-        </testResources>
-        <testSourceDirectory>../../org.eclipse.jgit.test/tst/</testSourceDirectory>
-        <plugins>
-            <plugin>
-                <artifactId>maven-compiler-plugin</artifactId>
-                <version>2.0.2</version>
-                <configuration>
-                    <source>1.5</source>
-                    <target>1.5</target>
-                    <encoding>UTF-8</encoding>
-                </configuration>
-            </plugin>
-            <plugin>
-                <artifactId>maven-surefire-plugin</artifactId>
-                <version>2.4.2</version>
-                <configuration>
-                    <includes>
-                        <include>**/*Test.java</include>
-                        <include>**/*TestCase.java</include>
-                        <include>**/T000*.java</include>
-                    </includes>
-                </configuration>
-           </plugin>
-           <plugin>
-               <artifactId>maven-source-plugin</artifactId>
-               <executions>
-                   <execution>
-                       <goals>
-                           <goal>jar</goal>
-                       </goals>
-                   </execution>
-               </executions>
-            </plugin>
-            <plugin>
-                <artifactId>maven-javadoc-plugin</artifactId>
-                <executions>
-                    <execution>
-                        <goals>
-                            <goal>jar</goal>
-                        </goals>
-                    </execution>
-                </executions>
-            </plugin>
-        </plugins>
-    </build>
-    <dependencies>
-        <dependency>
-            <groupId>junit</groupId>
-            <artifactId>junit</artifactId>
-            <version>3.8.1</version>
-            <scope>test</scope>
-        </dependency>
-        <dependency>
-            <groupId>com.jcraft</groupId>
-            <artifactId>jsch</artifactId>
-            <version>0.1.41</version>
-            <scope>compile</scope>
-        </dependency>
-    </dependencies>
-    <distributionManagement>
-        <snapshotRepository>
-            <id>jgit-maven-snapshot-repository</id>
-            <name>JGit Maven Snapshot Repository</name>
-            <url>dav:https://egit.googlecode.com/svn/maven/snapshot-repository/</url>
-            <uniqueVersion>true</uniqueVersion>
-        </snapshotRepository>
-    </distributionManagement>
-</project>
+<?xml version="1.0" encoding="UTF-8"?>
+<!--
+All rights reserved.
+Redistribution and use in source and binary forms, with or
+without modification, are permitted provided that the following
+conditions are met:
+
+Redistributions of source code must retain the above copyright
+notice, this list of conditions and the following disclaimer.
+
+Redistributions in binary form must reproduce the above
+copyright notice, this list of conditions and the following
+disclaimer in the documentation and/or other materials provided
+with the distribution.
+
+Neither the name of the Eclipse Foundation, Inc. nor the
+names of its contributors may be used to endorse or promote
+products derived from this software without specific prior
+written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+-->
+<project xmlns="http://maven.apache.org/POM/4.0.0"
+        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
+        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+    <modelVersion>4.0.0</modelVersion>
+    <parent>
+        <groupId>org.eclipse</groupId>
+        <artifactId>jgit-parent</artifactId>
+        <version>0.6.0-SNAPSHOT</version>
+    </parent>
+    <groupId>org.eclipse</groupId>
+    <artifactId>jgit</artifactId>
+    <packaging>jar</packaging>
+    <name>jgit</name>
+    <build>
+        <sourceDirectory>../../org.eclipse.jgit/src/</sourceDirectory>
+        <testResources>
+            <testResource>
+                <directory>../../org.eclipse.jgit.test/tst-rsrc/</directory>
+            </testResource>
+        </testResources>
+        <testSourceDirectory>../../org.eclipse.jgit.test/tst/</testSourceDirectory>
+    </build>
+    <dependencies>
+        <dependency>
+            <groupId>junit</groupId>
+            <artifactId>junit</artifactId>
+            <version>3.8.1</version>
+            <scope>test</scope>
+        </dependency>
+        <dependency>
+            <groupId>com.jcraft</groupId>
+            <artifactId>jsch</artifactId>
+            <version>0.1.41</version>
+            <scope>compile</scope>
+        </dependency>
+    </dependencies>
+</project>
diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/pom.xml
similarity index 90%
rename from jgit-maven/jgit/pom.xml
rename to jgit-maven/pom.xml
index d8772ad..bac9629 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/pom.xml
@@ -37,10 +37,10 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
     <modelVersion>4.0.0</modelVersion>
     <groupId>org.eclipse</groupId>
-    <artifactId>jgit</artifactId>
-    <packaging>jar</packaging>
+    <artifactId>jgit-parent</artifactId>
+    <packaging>pom</packaging>
     <version>0.6.0-SNAPSHOT</version>
-    <name>jgit</name>
+    <name>JGit</name>
     <url>http://repo.or.cz/w/jgit.git</url>
     <mailingLists>
         <mailingList>
@@ -141,13 +141,6 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
         </license>
     </licenses>
     <build>
-        <sourceDirectory>../../org.eclipse.jgit/src/</sourceDirectory>
-        <testResources>
-            <testResource>
-                <directory>../../org.eclipse.jgit.test/tst-rsrc/</directory>
-            </testResource>
-        </testResources>
-        <testSourceDirectory>../../org.eclipse.jgit.test/tst/</testSourceDirectory>
         <plugins>
             <plugin>
                 <artifactId>maven-compiler-plugin</artifactId>
@@ -191,20 +184,6 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
             </plugin>
         </plugins>
     </build>
-    <dependencies>
-        <dependency>
-            <groupId>junit</groupId>
-            <artifactId>junit</artifactId>
-            <version>3.8.1</version>
-            <scope>test</scope>
-        </dependency>
-        <dependency>
-            <groupId>com.jcraft</groupId>
-            <artifactId>jsch</artifactId>
-            <version>0.1.41</version>
-            <scope>compile</scope>
-        </dependency>
-    </dependencies>
     <distributionManagement>
         <snapshotRepository>
             <id>jgit-maven-snapshot-repository</id>
@@ -213,4 +192,8 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
             <uniqueVersion>true</uniqueVersion>
         </snapshotRepository>
     </distributionManagement>
+    <modules>
+        <module>jgit</module>
+        <module>jgit-io</module>
+    </modules>
 </project>
-- 
1.6.2.1
